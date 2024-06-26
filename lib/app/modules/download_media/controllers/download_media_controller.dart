import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/pairing_result.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

class DownloadMediaController extends GetxController {
  Rx<PairingResult>? pairingResult = PairingResult().obs;
  late Timer timer;
  RxBool isMediaDownloaded = false.obs;
  RxBool isTemplateFetched = false.obs;
  RxList<String> urls = <String>[].obs;
  List<MediaTempModel> tempList = [];
  RxString backgroundImage = ''.obs;
  var currentTemplateBackgroundColor = Rx<Color>(Colors.transparent);
  RxList<TemplateSingleItemModel> singleItemList =
      <TemplateSingleItemModel>[].obs;
  RxBool? isUnLock = true.obs;

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
        if (pairingResult != null) {
          pairingResult
              ?.value
              .uploadMedias?[pairingResult!.value.uploadMedias!
                  .indexWhere((element) => element.id == mediaTempModel.id)]
              .url = videoFilePath;
        }
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

  Future<void> getTemplates() async {
    String backgroundColor = '';
    String backgroundImg = '';
    List<TemplateSingleItemModel> temppItems = [];
    for (var item in tempList) {
      backgroundColor = item.backgroundColor!;
      backgroundImg = item.backgroundImage!;
      temppItems = item.templateElements!;
    }

    try {
      for (var model in pairingResult!.value.uploadMedias!) {
        // tempList.addAll(
        //   tempList.where((p0) => p0.orientation == 'Landscape'),
        // );

        for (var temp in model.templateElements!) {
          if (temp.type == 'Image') {
            temp.comingFrom = Strings.editElementImage;
          } else {
            if (model.type == 'Title') {
              temp.comingFrom = Strings.editElementTitle;
            } else if (model.type == 'Description') {
              temp.comingFrom = Strings.editElementDescription;
            } else {
              temp.comingFrom = Strings.editElementPrice;
            }
          }
          backgroundImage.value = backgroundImg;
          currentTemplateBackgroundColor.value =
              Utils.fetchColorFromStringColor(backgroundColor) ?? "";

          singleItemList.value = temppItems;

          temp.rect = Rect.fromLTWH(
            temp.xaxis!.toDouble() * 2.5.w ,
            temp.yaxis!.toDouble() *2.5.h,
            temp.width! * 3.w,
            temp.height! * 3.h,
          );
          temp.width = temp.width! * 2.w;
          temp.height = temp.height! * 2.h;
          temp.isSelected = false;
          temp.fontSize = (temp.fontSize == 0.0) ? 14 : temp.fontSize;
          temp.valueLocal = (temp.value == null || temp.value?.isEmpty == true)
              ? ''
              : temp.value;
        }
      }
      isTemplateFetched.value = true;
    } catch (e) {
      e.toString();
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

      for (var element in pairingResult!.value.uploadMedias!) {
        if (element.isTemplate!) {
          tempList.add(element);
        }
      }
      print('Temp List is $tempList');

      if (pairingResult!.value.uploadMedias != null) {
        for (var element in pairingResult!.value.uploadMedias!) {
          if (element.isTemplate == true) {
            await getTemplates();
          } else {
            await readFileFromPath(element);
          }
        }
        SharedPreferences.savePairingResultObject(pairingResult!.value);

        if (isMediaDownloaded.value == true ||
            isTemplateFetched.value == true) {
          Get.toNamed(
            Routes.VIDEO_PLAYER,
            arguments: {
              'urls': urls,
              // 'templates': tempList,
            },
          );
        }
      }
    }

    super.onReady();
  }
}
