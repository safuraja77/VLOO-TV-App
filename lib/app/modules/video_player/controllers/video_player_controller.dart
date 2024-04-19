import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControler extends GetxController {
  RxInt currentVideoIndex = 0.obs;
  RxList<String> videos = <String>[].obs;
  VideoPlayerController? videoController;

  @override
  void onInit() {
    if (Get.arguments != null) {
      videos.value = Get.arguments['urls'];
      initializeVideoController();
    }
    super.onInit();
  }

  void initializeVideoController() {
    videoController = VideoPlayerController.networkUrl(
        Uri.parse(videos[currentVideoIndex.value]));

    videoController!.initialize().then((_) {
      videoController!.play();
    });
    videoController!.addListener(
      () {
        if (videoController!.value.isCompleted) {
          onNext();
        }
      },
    );
  }

  void onNext() async {
    currentVideoIndex.value = (currentVideoIndex.value + 1) % videos.length;
    videoController!.dispose();

    videoController = VideoPlayerController.networkUrl(
        Uri.parse(videos[currentVideoIndex.value]));

    await videoController!.initialize();

    videoController!.play();
    initializeVideoController();
    update();
  }

  // void onPrevious() {
  //   if (currentVideoIndex > 0) {
  //     currentVideoIndex--;
  //     videoController!.dispose();
  //     videoController = VideoPlayerController.networkUrl(Uri.parse(
  //       videos[currentVideoIndex],
  //     ));
  //     videoController!.initialize();
  //     videoController!.play();
  //   }
  // }

  // void togglePause() {
  //   if (videoController != null && videoController!.value.isPlaying) {
  //     videoController!.pause();
  //   } else if (videoController != null) {
  //     videoController!.play();
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
    videoController!.dispose();
  }
}
