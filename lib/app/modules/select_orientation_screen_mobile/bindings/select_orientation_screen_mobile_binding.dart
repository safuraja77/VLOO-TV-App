import 'package:get/get.dart';

import '../controllers/select_orientation_screen_mobile_controller.dart';

class SelectOrientationScreenMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectOrientationScreenMobileController>(
      () => SelectOrientationScreenMobileController(),
    );
  }
}
