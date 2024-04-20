import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vloo_tv_v2/app/data/models/pairing_result.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

class DownloadMediaController extends GetxController {
  Rx<PairingResult>? pairingResult = PairingResult().obs;
  late Timer timer;
  RxBool isMediaDownloaded = false.obs;
  RxList<String> urls = <String>[].obs;

  Future<void> readFileFromPath(MediaTempModel mediaTempModel) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String videoFilePath =
          '${appDocDir.path}/${mediaTempModel.id}.${mediaTempModel.format}';
      log('Video file path is $videoFilePath');
      final File file = File(videoFilePath);
      urls.add(videoFilePath);
      log('Urls are $urls');
      if (file.existsSync()) {
        Get.toNamed(
          Routes.VIDEO_PLAYER,
          arguments: {
            'urls': urls,
          },
        );
      } else {
        var response = await http.get(Uri.parse(mediaTempModel.url!));
        await file.writeAsBytes(response.bodyBytes);
        await saveVideoToGallery(file.path);
        isMediaDownloaded.value = true;
        pairingResult!
            .value
            .uploadMedias?[pairingResult!.value.uploadMedias!
                .indexWhere((element) => element.id == mediaTempModel.id)]
            .url = videoFilePath;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> saveVideoToGallery(String videoPath) async {
    try {
      final result = await GallerySaver.saveVideo(videoPath);
      log('Result is ........ $result');
      log('VIdeo  is ........ $result');
      if (result == true) {
        log('Video saved successfully');
      } else {
        log('Failed to save video');
      }
    } catch (e) {
      log('Error saving video: $e');
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  @override
  void onReady() async {
    if (Get.arguments != null) {
      pairingResult!.value = Get.arguments as PairingResult;
      log('Title is ${pairingResult!.value.title}');
      log('ID  ${pairingResult!.value.id}');
      log('Orientation is  ${pairingResult!.value.orientation}');
      log('Code is  ${pairingResult!.value.screenCode}');
      print(pairingResult!.value.uploadMedias);

      if (pairingResult!.value.uploadMedias != null) {
        for (var element in pairingResult!.value.uploadMedias!) {
          // log(element.url ?? 'N');
          if (element.isTemplate == true) {
            Future.delayed(const Duration(seconds: 5), () {
              return const CircularProgressIndicator();
            });
          }
          element.isTemplate == true
              ? const Duration(seconds: 5)
              : await readFileFromPath(element);
        }
        SharedPreferences.savePairingResultObject(pairingResult!.value);

        if (isMediaDownloaded.value == true) {
          Get.toNamed(
            Routes.VIDEO_PLAYER,
            arguments: {
              'urls': urls,
            },
          );
        }
      }
    }
    // Get.put<PreviewTemplateController>(PreviewTemplateController());
    // Get.to(const PreviewTemplateView());
    super.onReady();
  }
}
