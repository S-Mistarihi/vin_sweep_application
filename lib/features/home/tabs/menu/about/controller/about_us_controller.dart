import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/about/repository/about_us_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

class AboutUsController extends GetxController {
  final RxnString aboutText = RxnString();
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    aboutText.value = CurrentSession().aboutUs;
    if (aboutText.value == null) loadAboutUs();
  }

  Future<void> loadAboutUs() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    final result = await createAboutUsRepository().getAboutUs(
      context: Get.context!,
    );

    switch (result) {
      case Failure(:final exception):
        if (aboutText.value == null) errorMessage.value = exception.message;
      case Success(:final data):
        CurrentSession().aboutUs = data.result;
        aboutText.value = data.result;
    }

    isLoading.value = false;
  }

  List<String> get paragraphs {
    final text = aboutText.value;
    if (text == null) return const [];
    return text
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
  }
}