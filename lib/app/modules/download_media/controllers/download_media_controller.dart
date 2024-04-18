import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/api_config.dart';
import 'package:vloo_tv_v2/app/data/models/pairing_result.dart';
import 'dart:developer';

class DownloadMediaController extends GetxController {
  PairingResult? pairingResult;
  List<String> urls = <String>[];

  // get method for api. (done)
  // fetch media. (TODO)
  // download and play media in a loop  if it is video.
  // if it is template, sho template but work with video for now. skip template.
  // use stream to get videos on runtime.

  // Future<PairingResult?> screenContents() async {
  //   const String apiUrl = ApiConfig.screenContent;
  //   const String token = '637|belJRxNS41iJKNePY9MMCJuLzBNljqZ8nooiAiw2';

  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   var dio = Dio();
  //   var response = await dio.request(
  //     apiUrl,
  //     options: Options(
  //       method: 'GET',
  //       headers: headers,
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonData = response.data;
  //     final result = jsonData['result'];
  //     pairingResult = PairingResult.fromJson(result);
  //     return pairingResult;
  //   } else {
  //     log('Error,==============> Failed to load data');
  //     throw Exception('Failed to load data');
  //   }
  // }

  // Future<void> downloadAndPlayVideo({required MediaModel media}) async {
  //   try {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String videoFilePath = '${appDocDir.path}/${media.id}.${media.format}';

  //     log('videoFilePath is following ==================== $videoFilePath');
  //     log('Format is ==================== ${media.format}');
  //     log('Format is ==================== ${media.localUrl}');
  //     File videoFile = File(videoFilePath);
  //     saveVideoToGallery(videoFile.path);
  //     var response = await http.get(Uri.parse(media.url!));
  //     await videoFile.writeAsBytes(response.bodyBytes);

  //     // pairingResult!
  //     //     .uploadMedias?[pairingResult!.uploadMedias!
  //     //         .indexWhere((element) => element.id! == media.id)]
  //     //     .localUrl = videoFilePath;
  //     if (videoFile.existsSync()) {
  //       if (!Get.isRegistered<DownloadMediaController>()) {
  //         Get.put<DownloadMediaController>(DownloadMediaController());
  //       }
  //     }
  //   } catch (e) {
  //     e.toString();
  //   }
  // }

  // Future<void> readFileFromPath({required MediaModel media}) async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String videoFilePath = '${appDocDir.path}/${media.id}.${media.format}';
  //   final File file = File(videoFilePath);
  //   urls.add(videoFilePath);
  //   pairingResult!
  //       .uploadMedias?[pairingResult!.uploadMedias!
  //           .indexWhere((element) => element.id! == media.id)]
  //       .localUrl = videoFilePath;
  //   if (file.existsSync()) {
  //     if (!Get.isRegistered<DownloadMediaController>()) {
  //       Get.put<DownloadMediaController>(DownloadMediaController());
  //     }
  //   } else {
  //     downloadAndPlayVideo(media: media);
  //   }
  // }

  // void saveVideoToGallery(String videoPath) async {
  //   try {
  //     final result = await GallerySaver.saveVideo(videoPath);
  //     log('Result is ........ $result');
  //     log('VIdeo  is ........ $result');
  //     if (result == true) {
  //       log('Video saved successfully');
  //     } else {
  //       log('Failed to save video');
  //     }
  //   } catch (e) {
  //     log('Error saving video: $e');
  //   }
  // }

  // // Future<void> getMediaConnectionPairing() async {
  // //   var code = SharedPreferences.getQrCode();

  // //   var dio = Dio();
  // //   var response = await dio.request("${AppUrls.mediaConnection}?code=$code",
  // //       options: Options(method: 'GET'));
  // //   try {
  // //     GetConnectionPairingResponse model =
  // //         GetConnectionPairingResponse.fromJson(response.data);
  // //     if (model.status == true && model.message == 'Screen Details') {
  // //       if (model.pairingResult != null &&
  // //           model.pairingResult!.screenCode != "") {
  // //         if (model.pairingResult!.orientation == "") {
  // //           Get.put<SelectOrientationScreenMobileController>(
  // //               SelectOrientationScreenMobileController());
  // //           Get.offNamed(Routes.selectOrientationScreenMobile);
  // //         } else {
  // //           if (model.pairingResult!.title == "") {
  // //             Get.put<NameScreenMobileController>(NameScreenMobileController());
  // //             Get.offNamed(Routes.nameScreenMobile);
  // //           } else {
  // //             if (model.pairingResult?.status != "Connected") {
  // //               Directory appDocDir = await getApplicationDocumentsDirectory();
  // //               String videoFilePath =
  // //                   '${appDocDir.path}/${media.value.id}.${media.value.format}';
  // //               final File file = File(videoFilePath);
  // //               if (file.existsSync()) {
  // //                 timer.cancel();
  // //               } else {
  // //                 Get.put<DownloadMediaController>(DownloadMediaController());
  // //                 Get.offAll(const DownloadMediaView(),
  // //                     arguments: model.pairingResult);
  // //               }
  // //             }
  // //           }
  // //         }
  // //       } else {
  // //         Get.snackbar('Success', 'Not Paired');
  // //       }
  // //     } else {
  // //       throw Exception('Failed');
  // //     }
  // //   } catch (error) {
  // //     throw Exception(error);
  // //   } finally {}
  // // }

  // @override
  // void onClose() {
  //   timer.cancel();
  //   super.onClose();
  // }

  @override
  void onReady() async {
    if (Get.arguments != null) {
      pairingResult = Get.arguments as PairingResult;
      log('Title is ${pairingResult!.title}');
      log('ID  ${pairingResult!.id}');
      log('Orientation is  ${pairingResult!.orientation}');
      // screenContents();

      if (pairingResult!.uploadMedias != null) {
        // for (var element in pairingResult!.uploadMedias!) {
        //   await readFileFromPath(media: element);
        // }

        // SharedPreferences.savePairingResultObject(pairingResult!);
        // Get.put<VideoPlayerControler>(
        //   VideoPlayerControler(videos: urls),
        // );
        // await Get.to(
        //   () => VideoPlayerView(urls: urls),
        // );
      }
    }
    super.onReady();
  }
}
