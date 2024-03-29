import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vloo_tv_v2/app/modules/media_player/controllers/media_player_controller.dart';

class MediaPlayerView extends GetView<MediaPlayerController> {
  final List<String> urls;
  const MediaPlayerView({
    super.key,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MediaPlayerController(videos: urls));
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            width: Get.width,
            height: Get.height,
            color: Colors.black,
            child: GetBuilder<MediaPlayerController>(
              builder: (controller) {
                if (controller.videoController != null ||
                    controller.videoController!.value.isInitialized) {
                  return AspectRatio(
                    aspectRatio: controller.videoController!.value.aspectRatio,
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
    );
  }
}
