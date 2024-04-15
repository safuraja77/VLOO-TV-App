import 'dart:async';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:vloo_tv_v2/app/data/models/MediaModel.dart';
import 'package:vloo_tv_v2/app/data/models/PairingResult.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/modules/video_player/controllers/video_player_controller.dart';
import 'package:vloo_tv_v2/app/modules/video_player/views/video_player_view.dart';

class DownloadMediaController extends GetxController {
  Rx<PairingResult> pairingResult = PairingResult().obs;
  Rx<MediaModel> media = MediaModel().obs;
  late Timer timer;
  List<String> urls = <String>[];

  Future<void> downloadAndPlayVideo({required MediaModel media}) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String videoFilePath = '${appDocDir.path}/${media.id}.${media.format}';
      print('videoFilePath is following ==================== $videoFilePath');
      print('Format is ==================== ${media.format}');
      print('Format is ==================== ${media.localUrl}');
      File videoFile = File(videoFilePath);
      saveVideoToGallery(videoFile.path);
      var response = await http.get(Uri.parse(media.url!));
      await videoFile.writeAsBytes(response.bodyBytes);

      pairingResult
          .value
          .uploadMedias?[pairingResult.value.uploadMedias!
              .indexWhere((element) => element.id! == media.id)]
          .localUrl = videoFilePath;
      if (videoFile.existsSync()) {
        if (!Get.isRegistered<DownloadMediaController>()) {
          Get.put<DownloadMediaController>(DownloadMediaController());
        }
      }
    } catch (e) {
      e.toString();
    }
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
      print('Result is ........ $result');
      print('VIdeo  is ........ $result');
      if (result == true) {
        print('Video saved successfully');
      } else {
        print('Failed to save video');
      }
    } catch (e) {
      print('Error saving video: $e');
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
  //       if (model.pairingResult != null &&
  //           model.pairingResult!.screenCode != "") {
  //         if (model.pairingResult!.orientation == "") {
  //           Get.put<SelectOrientationScreenMobileController>(
  //               SelectOrientationScreenMobileController());
  //           Get.offNamed(Routes.selectOrientationScreenMobile);
  //         } else {
  //           if (model.pairingResult!.title == "") {
  //             Get.put<NameScreenMobileController>(NameScreenMobileController());
  //             Get.offNamed(Routes.nameScreenMobile);
  //           } else {
  //             if (model.pairingResult?.status != "Connected") {
  //               Directory appDocDir = await getApplicationDocumentsDirectory();
  //               String videoFilePath =
  //                   '${appDocDir.path}/${media.value.id}.${media.value.format}';
  //               final File file = File(videoFilePath);
  //               if (file.existsSync()) {
  //                 timer.cancel();
  //               } else {
  //                 Get.put<DownloadMediaController>(DownloadMediaController());
  //                 Get.offAll(const DownloadMediaView(),
  //                     arguments: model.pairingResult);
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
      pairingResult.value = Get.arguments as PairingResult;
      if (pairingResult.value.uploadMedias != null) {
        for (var element in pairingResult.value.uploadMedias!) {
          await readFileFromPath(media: element);
        }
        SharedPreferences.savePairingResultObject(pairingResult.value);
        Get.put<VideoPlayerControler>(VideoPlayerControler(videos: urls));
        await Get.to(
          () => VideoPlayerView(urls: urls),
        );
      }
    }
    super.onReady();
  }
}
