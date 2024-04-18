import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:vloo_tv_v2/app/data/configs/api_config.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionPairingResponse.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionResponse.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/data/utils/app_urls.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';
import 'package:vloo_tv_v2/app/modules/download_media/views/download_media_view.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

class AttachMediaScreenMobileController extends GetxController {
  late Timer timer;
  RxString base64Image = ''.obs;
  RxString qrCode = ''.obs;
  bool isPopupShownOnce = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getMediaConnectionPairing();
    });
  }

  Future<void> getMediaConnection() async {
    var dio = Dio();
    var response = await dio.request(AppUrls.mediaConnection,
        options: Options(method: 'GET'));
    try {
      GetConnectionResponse model =
          GetConnectionResponse.fromJson(response.data);
      if (model.status == true && model.result != null) {
        if (model.result!.qr!.isNotEmpty &&
            model.result!.qr != "" &&
            model.result!.code!.isNotEmpty &&
            model.result!.code != "") {
          startTimer();
          base64Image.value = model.result!.qr!;
          qrCode.value = model.result!.code!;
        }
      } else {
        throw Exception('Failed');
      }
    } catch (error) {
      throw Exception(error);
    } finally {}
  }

  Future<void> getMediaConnectionPairing() async {
    var dio = Dio();
    var response = await dio.request(
        // "${AppUrls.mediaConnection}?code=${qrCode.value}",
        ApiConfig.screenContent,
        options: Options(method: 'GET'));
    try {
      GetConnectionPairingResponse model =
          GetConnectionPairingResponse.fromJson(response.data);
      if (model.status == true && model.message == 'Screen Details') {
        if (model.result != null && model.result!.screenCode != "") {
          SharedPreferences.saveQrCode(qrCode.value);
          if (model.result?.status != "Connected") {
            Get.offNamed(Routes.attachMediaScreenMobile);
            if (!isPopupShownOnce) {
              isPopupShownOnce = true;
              Future.delayed(
                const Duration(seconds: 5),
                (() {
                  Utils.alertDialogBox(
                      context: Get.context!,
                      description:
                          "Please attach media to this screen on mobile app to continue.",
                      pText: "Ok",
                      nText: "",
                      onPressedPositive: () {
                        Navigator.of(Get.context!).pop();
                        isPopupShownOnce = true;
                      },
                      onPressedNegative: () {
                        Navigator.of(Get.context!).pop();
                      });
                }),
              );
            } else {
              Get.put<DownloadMediaController>(DownloadMediaController());
              Get.to(const DownloadMediaView(), arguments: model.result);
              timer.cancel();
            }
          }
        } else {
          throw Exception('Failed');
        }
      }
    } catch (error) {
      error.toString();
    }
  }
}
