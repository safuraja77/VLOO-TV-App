// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/modules/video_player/controllers/video_player_controller.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

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
              title: const Text('Confirm Refresh'),
              content: const Text('Are you sure you want to refresh th app?'),
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
            return Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black,
              child: GetBuilder<VideoPlayerControler>(
                builder: (controller) {
                  if (controller.videoController != null ||
                      controller.videoController!.value.isInitialized) {
                    return AspectRatio(
                      aspectRatio:
                          controller.videoController!.value.aspectRatio,
                      child: VideoPlayer(controller.videoController!),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
