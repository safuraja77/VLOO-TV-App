import 'dart:async';
import 'dart:ui';

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
  final RxList<Offset> startDragOffset = <Offset>[].obs;

  void mediaControllers() async {
    if (videos.isNotEmpty && templates.isEmpty) {
      videoController = VideoPlayerController.network(
        videos[currentVideoIndex],
      );
      await videoController!.initialize();
      videoController!.play();
      update();

      videoController!.addListener(
        () {
          if (videoController!.value.isCompleted) {
            currentVideoIndex = (currentVideoIndex + 1) % videos.length;
            videoController!.dispose();
            mediaControllers();
          }
        },
      );
    } else if (videos.isEmpty && templates.isNotEmpty) {
      if (!(currentTempIndex == templates.length)) {
        isTemp.value = true;
        currentTemplate = templates[currentTempIndex];
        update();

        Timer(const Duration(seconds: 10), () {
          currentTempIndex = (currentTempIndex + 1) % templates.length;
          isTemp.value = false;
          update();
          mediaControllers();
        });
      } else {
        currentTempIndex = 0;
        mediaControllers();
      }
    } else if (videos.isNotEmpty && templates.isNotEmpty) {
      if (!(currentVideoIndex == videos.length)) {
        videoController = VideoPlayerController.network(
          videos[currentVideoIndex],
        );
        await videoController!.initialize();
        videoController!.play();
        update();

        videoController!.addListener(
          () {
            if (videoController!.value.isCompleted) {
              currentVideoIndex = (currentVideoIndex + 1);
              videoController!.dispose();
              mediaControllers();
            }
          },
        );
      } else {
        if (!(currentTempIndex == templates.length)) {
          isTemp.value = true;
          currentTemplate = templates[currentTempIndex];
          update();

          Timer(
            const Duration(seconds: 10),
            () {
              currentTempIndex = (currentTempIndex + 1);
              isTemp.value = false;
              update();
              mediaControllers();
            },
          );
        } else {
          currentVideoIndex = 0;
          currentTempIndex = 0;
          mediaControllers();
        }
      }
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

      mediaControllers();
    }
    super.onInit();
  }
}
