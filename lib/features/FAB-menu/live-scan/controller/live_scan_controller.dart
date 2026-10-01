import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/text-recognition/vin_reader_manager.dart';
import '../../../../utils/text-recognition/vin_reader_model.dart';

class LiveScanController extends GetxController {
  CameraController? cameraController;
  late final TextRecognizer _textRecognizer;

  final RxBool isCameraInitialized = false.obs;
  final RxBool vinFound = false.obs;
  final RxBool isFlashOn = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString detectedVin = ''.obs;

  bool _isBusy = false;
  bool _finished = false;
  bool _closed = false;

  DateTime? _lastProcessedTime;
  DateTime? _lastCandidateTime;

  // تصويت بين الفريمات: كل VIN وكم مرة انقرأ
  final Map<String, int> _votes = {};

  // VIN صحيح (check digit مضبوط): بنقبله من أول قراءة، زي كودك
  static const int _validVotes = 1;

  // VIN بطول 17 بس بدون check digit صحيح (isBackup): لازم 4 مرات
  // المستخدم بقدر يعدله بصفحة النتيجة
  static const int _backupVotes = 4;

  @override
  void onInit() {
    super.onInit();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    initializeCamera();
    //Future.delayed(const Duration(seconds: 2), () => Get.back<String>(result: '5GTEN13E888105458'));
  }

  // ---------------------------------------------------------------------------
  // CAMERA
  // ---------------------------------------------------------------------------

  Future<void> initializeCamera() async {
    try {
      errorMessage.value = '';

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        errorMessage.value = S.of(Get.context!).noCameraWasFound;
        return;
      }

      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      cameraController = controller;

      await controller.initialize();
      if (_closed) return;

      try {
        await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
        await controller.setFocusMode(FocusMode.auto);
        await controller.setExposureMode(ExposureMode.auto);
      } catch (_) {
        // بعض الأجهزة ما بتدعم هاي الخيارات
      }

      isCameraInitialized.value = true;
      await controller.startImageStream(_processCameraImage);
    } on CameraException catch (e) {
      errorMessage.value = e.code == 'CameraAccessDenied'
          ? S.of(Get.context!).cameraPermissionDeniedPleaseEnableItFromSettings
          : (e.description ?? S.of(Get.context!).unableToInitializeCamera);
    } catch (e) {
      errorMessage.value = S
          .of(Get.context!)
          .somethingWentWrongWhileOpeningTheCamera;
      debugPrint('Camera init error: $e');
    }
  }

  Future<void> toggleFlash() async {
    final controller = cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      final bool on = !isFlashOn.value;
      await controller.setFlashMode(on ? FlashMode.torch : FlashMode.off);
      isFlashOn.value = on;
    } catch (e) {
      debugPrint('Flash error: $e');
    }
  }

  Future<void> _stopStream() async {
    try {
      final c = cameraController;
      if (c != null && c.value.isStreamingImages) {
        await c.stopImageStream();
      }
    } catch (e) {
      debugPrint('Stop stream error: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // PROCESSING
  // ---------------------------------------------------------------------------

  Future<void> _processCameraImage(CameraImage image) async {
    if (_finished || _isBusy) return;

    final now = DateTime.now();
    if (_lastProcessedTime != null &&
        now.difference(_lastProcessedTime!).inMilliseconds < 300) {
      return;
    }
    _lastProcessedTime = now;
    _isBusy = true;

    try {
      final input = _toInputImage(image);
      if (input == null) return;

      final text = await _textRecognizer.processImage(input);
      if (_finished || _closed) return;

      await _handleText(text);
    } catch (e) {
      debugPrint('Image processing error: $e');
    } finally {
      _isBusy = false;
    }
  }

  Future<void> _handleText(RecognizedText text) async {
    final now = DateTime.now();

    // إذا مرت 3 ثواني بدون أي مرشح نبدأ التصويت من جديد
    if (_lastCandidateTime != null &&
        now.difference(_lastCandidateTime!).inSeconds >= 3) {
      _votes.clear();
    }

    // isLiveScan: false => الـ manager بجرب البحث داخل السطر (sliding window)
    // إذا ما لقي VIN صحيح، بدون أي تعديل على الـ manager نفسه
    final List<VinReaderModel> vins = VinReaderManager().detectVins(
      text,
      isLiveScan: false,
    );

    if (vins.isEmpty) return;

    // VIN الصحيحة أولاً
    vins.sort((a, b) => (a.isBackup ? 1 : 0).compareTo(b.isBackup ? 1 : 0));

    for (final VinReaderModel m in vins) {
      // الـ backup لازم يكون 17 خانة عشان نقبله
      if (m.isBackup && m.vin.length != 17) continue;

      _lastCandidateTime = now;

      final int votes = (_votes[m.vin] ?? 0) + 1;
      _votes[m.vin] = votes;

      final int needed = m.isBackup ? _backupVotes : _validVotes;

      debugPrint(
        'VIN candidate ${m.vin} $votes/$needed '
        '(backup: ${m.isBackup})',
      );

      if (votes >= needed) {
        await _onVinConfirmed(m.vin);
        return;
      }
    }
  }

  Future<void> _onVinConfirmed(String vin) async {
    if (_finished) return;
    _finished = true;

    detectedVin.value = vin;
    vinFound.value = true;

    await _stopStream();

    // نخلي المستخدم يشوف "VIN detected ✓" لحظة
    await Future.delayed(const Duration(milliseconds: 600));

    if (!_closed) {
      Get.back<String>(result: vin);
    }
  }

  // ---------------------------------------------------------------------------
  // ML KIT INPUT IMAGE
  // ---------------------------------------------------------------------------

  InputImage? _toInputImage(CameraImage image) {
    final controller = cameraController;
    if (controller == null) return null;

    final camera = controller.description;
    final int sensor = camera.sensorOrientation;

    InputImageRotation? rotation;

    if (Platform.isIOS) {
      // على iOS الدوران = sensorOrientation مباشرة
      rotation = InputImageRotationValue.fromRawValue(sensor);
    } else if (Platform.isAndroid) {
      const orientations = {
        DeviceOrientation.portraitUp: 0,
        DeviceOrientation.landscapeLeft: 90,
        DeviceOrientation.portraitDown: 180,
        DeviceOrientation.landscapeRight: 270,
      };
      int? compensation = orientations[controller.value.deviceOrientation];
      if (compensation == null) return null;

      if (camera.lensDirection == CameraLensDirection.front) {
        compensation = (sensor + compensation) % 360;
      } else {
        compensation = (sensor - compensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(compensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DISPOSE
  // ---------------------------------------------------------------------------

  @override
  void onClose() {
    _closed = true;
    _finished = true;
    cameraController?.dispose();
    _textRecognizer.close();
    super.onClose();
  }
}
