import 'package:get/get.dart';

import '../controllers/attach_media_screen_mobile_controller.dart';

class AttachMediaScreenMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttachMediaScreenMobileController>(
      () => AttachMediaScreenMobileController(),
    );
  }
}
