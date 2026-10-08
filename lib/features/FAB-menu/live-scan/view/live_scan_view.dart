import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/ui/custom_loading_indicator.dart';
import '../controller/live_scan_controller.dart';

class LiveScanView extends StatefulWidget {
  const LiveScanView({super.key});

  @override
  State<LiveScanView> createState() => _LiveScanViewState();
}

class _LiveScanViewState extends State<LiveScanView>
    with SingleTickerProviderStateMixin {
  late final LiveScanController controller;
  late final AnimationController lineController;

  static const double _boxHeight = 350;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LiveScanController());
    lineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    lineController.dispose();
    Get.delete<LiveScanController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().accentColor,
      body: Obx(() {
        if (controller.errorMessage.value.isNotEmpty) {
          return _buildError();
        }
        if (!controller.isCameraInitialized.value) {
          return CustomLoadingIndicator(isLoadMore: true);
        }
        return _buildScanner();
      }),
    );
  }

  Widget _buildError() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors().baseColor, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.initializeCamera,
                child: Text(S.of(context).tryAgain),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(S.of(context).close),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanner() {
    final camera = controller.cameraController!;
    final previewSize = camera.value.previewSize!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        final double h = constraints.maxHeight;

        final Rect cutout = Rect.fromCenter(
          center: Offset(w / 2, h / 2),
          width: w - 20,
          height: _boxHeight,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: previewSize.height,
                  height: previewSize.width,
                  child: CameraPreview(camera),
                ),
              ),
            ),

            Positioned.fill(
              child: CustomPaint(painter: _ScanOverlayPainter(cutout)),
            ),

            Positioned.fromRect(
              rect: cutout,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: lineController,
                    builder: (_, _) => Positioned(
                      top: lineController.value * (_boxHeight - 2),
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors().scanningLine,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors().scanningLine,
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: AppColors().baseColor),
                          onPressed: () => Get.back(),
                        ),
                        const Spacer(),
                        Obx(
                          () => IconButton(
                            icon: Icon(
                              controller.isFlashOn.value
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: AppColors().baseColor,
                            ),
                            onPressed: controller.toggleFlash,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).scanTheVinNumberOfYourCar,
                        style: TextStyle(
                          color: AppColors().baseColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Obx(
                () => Text(
                  controller.vinFound.value
                      ? S.of(context).vinDetected
                      : S.of(context).scanning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.vinFound.value
                        ? AppColors().successDialogColor
                        : AppColors().baseColor,
                    fontSize: 20,
                    fontWeight: controller.vinFound.value
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter(this.cutout);

  final Rect cutout;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Path()..addRect(Offset.zero & size);
    final hole = Path()
      ..addRRect(RRect.fromRectAndRadius(cutout, const Radius.circular(8)));

    canvas.drawPath(
      Path.combine(PathOperation.difference, background, hole),
      Paint()..color = Colors.black.withOpacity(0.55),
    );
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter old) => old.cutout != cutout;
}
