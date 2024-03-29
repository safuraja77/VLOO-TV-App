import 'package:get/get.dart';

import '../controllers/scan_code_screen_controller.dart';

class ScanCodeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanCodeScreenController>(
      () => ScanCodeScreenController(),
    );
  }
}
