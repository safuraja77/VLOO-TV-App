import 'package:get/get.dart';

import '../controllers/download_media_controller.dart';

class DownloadMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadMediaController>(
      () => DownloadMediaController(),
    );
  }
}
