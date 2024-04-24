// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
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
        body: OrientationBuilder(
          builder: (context, orientation) {
            print(controller.isTemp.value);
            return Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black,
              child: controller.isTemp.value
                  ? GetBuilder<VideoPlayerControler>(
                      builder: (controler) {
                        return AspectRatio(
                          aspectRatio: 16.w / 9.h,
                          child: Container(
                            color: Colors.white,
                            child: DragAndResizeWidget(
                              singleItemList: controller
                                  .currentTemplate.value.templateElements!,
                              // startDragOffset: controller.startDragOffset,
                              backgroundImage: controller.currentTemplate.value
                                  .templateElements!.first.backgroundImage,
                              isBottomSheetLocked: false,
                              // selectedTemplateBackGroundColor: Color(
                              //   int.parse(
                              //     controller.currentTemplate.value
                              //         .templateElements!.first.backgroundColor!,
                              //   ),
                              // ),
                              orientation: Strings.landscape,
                              callBack: (list) {},
                            ),
                          ),
                        );
                      },
                    )
                  : GetBuilder<VideoPlayerControler>(
                      builder: (controller) {
                        if (controller.videos.isNotEmpty) {
                          if (controller.videoController != null ||
                              controller.videoController!.value.isInitialized) {
                            return AspectRatio(
                              aspectRatio:
                                  controller.videoController!.value.aspectRatio,
                              child: VideoPlayer(controller.videoController!),
                            );
                          }
                        }
                        return Container(
                          color: Colors.red,
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
