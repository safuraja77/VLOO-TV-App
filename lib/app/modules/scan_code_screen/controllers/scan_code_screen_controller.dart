import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionPairingResponse.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionResponse.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/data/utils/app_urls.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';
import 'package:vloo_tv_v2/app/modules/attach_media_screen_mobile/controllers/attach_media_screen_mobile_controller.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';
import 'package:vloo_tv_v2/app/modules/download_media/views/download_media_view.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

class ScanCodeScreenController extends GetxController {
  RxString base64Image = ''.obs;
  RxString qrCode = ''.obs;
  late Timer timer;
  bool isPopupShownOnce = false;

  Image getBase64ToImage() {
    if (base64Image.value.isNotEmpty) {
      List<int> imageBytes = base64.decode(base64Image.value);
      return Image.memory(Uint8List.fromList(imageBytes),
          width: 230.w, height: 230.h);
    } else {
      return Image.asset(StaticAssets.noImageIcon, width: 230.w, height: 230.h);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (SharedPreferences.getQrCode() == null ||
        SharedPreferences.getQrCode()?.isEmpty == true) getMediaConnection();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
    var response = await dio.request("${AppUrls.mediaConnection}?code=$qrCode",
        options: Options(method: 'GET'));
    try {
      GetConnectionPairingResponse model =
          GetConnectionPairingResponse.fromJson(response.data);
      if (model.status == true && model.message == 'Screen Details') {
        if (model.pairingResult != null &&
            model.pairingResult!.screenCode != "") {
          SharedPreferences.saveQrCode(qrCode.value);
          if (model.pairingResult!.orientation == "") {
            Get.offNamed(Routes.selectOrientationScreenMobile);
          } else {
            if (model.pairingResult!.title == "") {
              Get.offNamed(Routes.nameScreenMobile);
            } else {
              if (model.pairingResult?.status != "Connected") {
                Get.put<AttachMediaScreenMobileController>(
                    AttachMediaScreenMobileController());
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
                }
              } else {
                Get.put<DownloadMediaController>(DownloadMediaController());
                Get.to(
                  const DownloadMediaView(),
                );
                timer.cancel();
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
      error.toString();
    } finally {}
  }
}
