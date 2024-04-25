import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';

class VideoPlayerControler extends GetxController {
  int currentVideoIndex = 0;
  List<String> videos = [];
  late Timer timer;
  List<MediaTempModel> templates = <MediaTempModel>[].obs;
  VideoPlayerController? videoController;
  RxBool isTemp = false.obs;
  int currentTempIndex = 0;
  var currentTemplate = MediaTempModel();

  void initializeVideoController() {
    if (videos.isNotEmpty) {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(
          videos[currentVideoIndex],
        ),
      );

      videoController!.initialize().then(
        (_) {
          videoController!.play();
        },
      );
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
    if (videos.isNotEmpty && !(currentVideoIndex == videos.length )) {
      print(
        'Video Index Value is $currentVideoIndex',
      );

      if (templates.isEmpty) {
        currentVideoIndex = (currentVideoIndex + 1) % videos.length;
      } else {
        currentVideoIndex = currentVideoIndex + 1;
      }
      print(
        'Video Index Value is $currentVideoIndex',
      );
      if (templates.isNotEmpty) {
        currentTempIndex = 0;
      }

      videoController = VideoPlayerController.networkUrl(
          Uri.parse(videos[currentVideoIndex]));
      await videoController!.initialize(); // codec error
      videoController!.play();
      initializeVideoController();

      update();
    } else if (templates.isNotEmpty) {
      videoController?.dispose();
      if (!(currentTempIndex == templates.length)) {
        isTemp.value = true;
        print('Video Index Value is $currentTempIndex');
        currentTemplate = templates[currentTempIndex];
        print('Video Index Value is $currentTempIndex');
        update();
        templateController();
      } else {
        isTemp.value = false;
        currentVideoIndex = (currentVideoIndex + 1) % videos.length;

        videoController = VideoPlayerController.networkUrl(
            Uri.parse(videos[currentVideoIndex]));
        await videoController!.initialize();
        videoController!.play();
        initializeVideoController();
        update();
      }
    }
  }

  void templateController() {
    if (templates.isNotEmpty) {
      print('Template Index Value is $currentTempIndex');

      Timer(
        const Duration(seconds: 5),
        () {
          if (videos.isEmpty) {
            currentTempIndex = (currentTempIndex + 1) % templates.length;
          } else {
            currentTempIndex = currentTempIndex + 1;
          }
          print('Template Index Value is $currentTempIndex');

          if (videos.isNotEmpty && currentTempIndex == templates.length) {
            isTemp.value = false;
            currentVideoIndex = -1;
          }
          onNext();
          print('Template Index Value is $currentTempIndex');
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    videoController!.dispose();
    timer.cancel();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      videos = Get.arguments['urls'] as List<String>;

      templates = Get.find<DownloadMediaController>().tempList;

      initializeVideoController();
    }
    super.onInit();
  }
}
