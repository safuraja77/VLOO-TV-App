import 'package:get/get.dart';

import '../controllers/preview_template_controller.dart';

class PreviewTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewTemplateController>(
      () => PreviewTemplateController(),
    );
  }
}
