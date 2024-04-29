import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';
import 'package:vloo_tv_v2/app/modules/previewTemplate/views/resize.dart';
import 'package:vloo_tv_v2/app/modules/video_player/controllers/video_player_controller.dart';

class VideoPlayerView extends GetView<VideoPlayerControler> {
  const VideoPlayerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to close th app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        if (exitConfirmed) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black,
          child: Obx(
            () {
              return controller.isTemp.value
                  ? GetBuilder<VideoPlayerControler>(
                      builder: (controler) {
                        return Container(
                          color: Colors.white,
                          child: DragAndResizeWidget(
                            singleItemList: controler
                                .currentTemplate.templateElements!,
                            startDragOffset: controller.startDragOffset,
                            backgroundImage:
                                controler.currentTemplate.backgroundImage,
                            isBottomSheetLocked: false,
                            selectedTemplateBackGroundColor:
                                Utils.fetchColorFromStringColor(controler
                                    .currentTemplate.backgroundColor),
                            orientation: Strings.landscape,
                            callBack: (list) {},
                          ),
                        );
                      },
                    )
                  : GetBuilder<VideoPlayerControler>(
                      builder: (controler) {
                        if (controler.videos.isNotEmpty) {
                          if (controler.videoController != null ||
                              controler
                                  .videoController!.value.isInitialized) {
                            return AspectRatio(
                              aspectRatio: controler
                                  .videoController!.value.aspectRatio,
                              child:
                                  VideoPlayer(controler.videoController!),
                            );
                          }
                        }
                        return Container(
                          color: Colors.red,
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
