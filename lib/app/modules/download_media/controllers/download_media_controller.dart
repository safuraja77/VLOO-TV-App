import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionPairingResponse.dart';
import 'package:vloo_tv_v2/app/data/models/MediaModel.dart';
import 'package:vloo_tv_v2/app/data/models/PairingResult.dart';
import 'package:http/http.dart' as http;
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/data/utils/app_urls.dart';
import 'package:vloo_tv_v2/app/modules/download_media/views/download_media_view.dart';
import 'package:vloo_tv_v2/app/modules/media_player/views/media_player_view.dart';

class DownloadMediaController extends GetxController {
  Rx<PairingResult> pairingResult = PairingResult().obs;
  late Timer timer;
  RxList<String> urls = <String>[].obs;

  Future<void> downloadAndPlayVideo({required MediaModel media}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String videoFilePath = '${appDocDir.path}/${media.id}.${media.format}';
    File videoFile = File(videoFilePath);
    saveVideoToGallery(videoFile.path);
    var response = await http.get(Uri.parse(media.url!));
    await videoFile.writeAsBytes(response.bodyBytes);

    pairingResult
        .value
        .uploadMedias?[pairingResult.value.uploadMedias!
            .indexWhere((element) => element.id! == media.id)]
        .localUrl = videoFilePath;
    readFileFromPath(media: media);
  }

  Future<void> readFileFromPath({required MediaModel media}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String videoFilePath = '${appDocDir.path}/${media.id}.${media.format}';
    final File file = File(videoFilePath);
    urls.add(videoFilePath);
    pairingResult
        .value
        .uploadMedias?[pairingResult.value.uploadMedias!
            .indexWhere((element) => element.id! == media.id)]
        .localUrl = videoFilePath;
    if (file.existsSync()) {
      if (!Get.isRegistered<DownloadMediaController>()) {
        Get.put<DownloadMediaController>(DownloadMediaController());
      }
    } else {
      downloadAndPlayVideo(media: media);
    }
  }

  void saveVideoToGallery(String videoPath) async {
    try {
      final result = await GallerySaver.saveVideo(videoPath);
      print('Result is $result');

      if (result != null && result == true) {
        print('Video saved successfully');
      } else {
        print('Failed to save video');
      }
    } catch (e) {
      print('Error saving video: $e');
    }
  }

  Future<void> getMediaConnectionPairing() async {
    var code = SharedPreferences.getQrCode();

    var dio = Dio();
    var response = await dio.request("${AppUrls.mediaConnection}?code=$code",
        options: Options(method: 'GET'));
    try {
      GetConnectionPairingResponse model =
          GetConnectionPairingResponse.fromJson(response.data);
      if (model.status == true && model.message == 'Screen Details') {
        if (model.pairingResult != null &&
            model.pairingResult!.screenCode != "") {
          if (model.pairingResult!.orientation == "") {
          } else {
            if (model.pairingResult!.title == "") {
            } else {
              if (model.pairingResult?.status != "Connected") {
              } else {
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String videoFilePath = '${appDocDir.path}/my_video.mp4';
                final File file = File(videoFilePath);
                if (file.existsSync()) {
                  // Step 5: Play video directly
                  timer.cancel();
                } else {
                  // Step4: Download media
                  Get.put<DownloadMediaController>(DownloadMediaController());
                  Get.offAll(const DownloadMediaView(),
                      arguments: model.pairingResult);
                }
              }
            }
          }
        } else {
          Get.snackbar('Success', 'Not Paired');
        }
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      throw Exception(error);
    } finally {}
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  @override
  void onReady() async {
    if (Get.arguments != null) {
      pairingResult.value = Get.arguments as PairingResult;
      if (pairingResult.value.uploadMedias != null) {
        for (var element in pairingResult.value.uploadMedias!) {
          await readFileFromPath(media: element);
        }
        SharedPreferences.savePairingResultObject(pairingResult.value);
        await Get.to(MediaPlayerView(urls: urls));
      }
    }
    super.onReady();
  }
}
