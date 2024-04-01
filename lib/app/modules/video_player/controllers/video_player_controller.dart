import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControler extends GetxController {
  int currentVideoIndex = 0;
  List<String> videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];
  VideoPlayerControler({required this.videos});
  VideoPlayerController? videoController;

  @override
  void onInit() {
    super.onInit();
    print("Initializing video controller bla bla bla");
    initializeVideoController();
  }

  void initializeVideoController() {
    print("Current index  is $currentVideoIndex");

    videoController =
        VideoPlayerController.networkUrl(Uri.parse(videos[currentVideoIndex]));

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
    print(
        'Current index: =====> $currentVideoIndex, Videos length: ====> ${videos.length}');

    currentVideoIndex = (currentVideoIndex + 1) % videos.length;
    print('Current index is =====> $currentVideoIndex');
    videoController!.dispose();

    videoController =
        VideoPlayerController.networkUrl(Uri.parse(videos[currentVideoIndex]));

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
