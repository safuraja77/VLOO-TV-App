import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';

class VideoPlayerControler extends GetxController {
  RxInt currentVideoIndex = 0.obs;
  RxList<String> videos = <String>[].obs;
  late Timer timer;
  RxList<MediaTempModel> templates = <MediaTempModel>[].obs;
  VideoPlayerController? videoController;
  RxBool isTemp = false.obs;
  RxInt currentTempIndex = 0.obs;
  var currentTemplate = MediaTempModel().obs;

  void initializeVideoController() {
    if (videos.isNotEmpty) {
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
    } else {
      onNext();
    }
  }

  void onNext() async {
    if (videos.isNotEmpty && !(currentVideoIndex.value == videos.length - 1)) {
      isTemp.value = false;
      currentVideoIndex.value = (currentVideoIndex.value + 1) % videos.length;
      videoController!.dispose();

      videoController = VideoPlayerController.networkUrl(
          Uri.parse(videos[currentVideoIndex.value]));
      await videoController!.initialize();
      videoController!.play();
      initializeVideoController();
      update();
    } else if (templates.isNotEmpty) {
      if (videos.isNotEmpty) {
        videoController!.dispose();
      }
      if (!(currentTempIndex.value == templates.length - 1) ||
          currentTempIndex.value == templates.length - 1) {
        isTemp.value = true;
        log(currentTempIndex.value);

        // currentTemplate.value = templates[currentTempIndex.value];
            currentTemplate.value = templates[currentTempIndex.value];

        Timer(
          const Duration(seconds: 5),
          () {

            currentTempIndex.value =
                (currentTempIndex.value + 1) % templates.length;
            log(currentTempIndex.value);
          },
        );
        log(currentTempIndex.value);

      } else {
        isTemp.value = false;
        currentVideoIndex.value = (currentVideoIndex.value + 1) % videos.length;

        videoController = VideoPlayerController.networkUrl(
            Uri.parse(videos[currentVideoIndex.value]));
        await videoController!.initialize();
        videoController!.play();
        initializeVideoController();
        update();
      }
    }
  }

  void displayNextTemplate() {
    if (currentTempIndex.value < templates.length - 1) {
      currentTemplate.value = templates[currentTempIndex.value];
      isTemp.value = true;
      print("template nmbr  ${currentTempIndex.value}");

      Future.delayed(const Duration(seconds: 5), () {
        print("Checking for more templates");
        currentTempIndex.value =
            (currentTempIndex.value + 1) % templates.length;
        displayNextTemplate();
      });
    } else {
      print("All templates displayed");
      isTemp.value = false;
      onNext();
    }
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

  @override
  void onInit() {
    if (Get.arguments != null) {
      videos.value = Get.arguments['urls'] as List<String>;

      templates.value = Get.find<DownloadMediaController>().tempList;

      print('Templateeeeeees $templates');
      initializeVideoController();
    }
    super.onInit();
  }

  // @override
  // void onReady() {
  //   if (Get.arguments != null) {
  //     videos.value = Get.arguments['urls'] as List<String>;

  //     templates.value = Get.find<DownloadMediaController>().tempList;

  //     print('Templateeeeeees $templates');
  //     initializeVideoController();
  //   }

  //   super.onReady();
  // }
}
