import 'dart:async';
import 'dart:io';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
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

  // Future<void> getMediaConnectionPairing() async {
  //   var code = SharedPreferences.getQrCode();

  //   var dio = Dio();
  //   var response = await dio.request("${AppUrls.mediaConnection}?code=$code",
  //       options: Options(method: 'GET'));
  //   try {
  //     GetConnectionPairingResponse model =
  //         GetConnectionPairingResponse.fromJson(response.data);
  //     if (model.status == true && model.message == 'Screen Details') {
  //       if (model.result != null && model.result!.screenCode != "") {
  //         if (model.result!.orientation == "") {
  //           Get.put<SelectOrientationScreenMobileController>(
  //               SelectOrientationScreenMobileController());
  //           Get.offNamed(Routes.selectOrientationScreenMobile);
  //         } else {
  //           if (model.result!.title == "") {
  //             Get.put<NameScreenMobileController>(NameScreenMobileController());
  //             Get.offNamed(Routes.nameScreenMobile);
  //           } else {
  //             if (model.result?.status != "Connected") {
  //               Directory appDocDir = await getApplicationDocumentsDirectory();
  //               String videoFilePath =
  //                   '${appDocDir.path}/${mediaTempModel.id}.${mediaTempModel.format}';
  //               final File file = File(videoFilePath);
  //               if (file.existsSync()) {
  //                 timer.cancel();
  //               } else {
  //                 Get.put<DownloadMediaController>(DownloadMediaController());
  //                 Get.offAll(const DownloadMediaView(),
  //                     arguments: model.result);
  //               }
  //             }
  //           }
  //         }
  //       } else {
  //         Get.snackbar('Success', 'Not Paired');
  //       }
  //     } else {
  //       throw Exception('Failed');
  //     }
  //   } catch (error) {
  //     throw Exception(error);
  //   } finally {}
  // }

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

      if (pairingResult!.value.uploadMedias != null) {
        for (var element in pairingResult!.value.uploadMedias!) {
          log(element.url ?? 'N');
          await readFileFromPath(element);
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
    super.onReady();
  }
}
