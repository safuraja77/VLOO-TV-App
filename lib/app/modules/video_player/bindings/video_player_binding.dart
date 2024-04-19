import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/modules/video_player/controllers/video_player_controller.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayerControler>(
      () => VideoPlayerControler(),
    );
  }
}
