import 'package:get/get.dart';

import '../controllers/name_screen_mobile_controller.dart';

class NameScreenMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NameScreenMobileController>(
      () => NameScreenMobileController(),
    );
  }
}
