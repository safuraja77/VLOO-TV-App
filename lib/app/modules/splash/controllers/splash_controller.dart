import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/models/GetConnectionPairingResponse.dart';
import 'package:vloo_tv_v2/app/data/utils/SharedPreferences.dart';
import 'package:vloo_tv_v2/app/data/utils/app_urls.dart';
import 'package:vloo_tv_v2/app/modules/attach_media_screen_mobile/controllers/attach_media_screen_mobile_controller.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';
import 'package:vloo_tv_v2/app/modules/download_media/views/download_media_view.dart';
import 'package:vloo_tv_v2/app/modules/name_screen_mobile/controllers/name_screen_mobile_controller.dart';
import 'package:vloo_tv_v2/app/modules/scan_code_screen/controllers/scan_code_screen_controller.dart';
import 'package:vloo_tv_v2/app/modules/select_orientation_screen_mobile/controllers/select_orientation_screen_mobile_controller.dart';
import 'package:vloo_tv_v2/app/routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimationPositionUpDown;
  late Animation<Offset> slideAnimationPositionLeftRight;

  RxBool logoVisible = true.obs;
  RxBool isVisible = false.obs;

  void startAnimations() {
    scaleController.forward();
    scaleController.addListener(() {});
  }

  @override
  void onReady() {
    var code = SharedPreferences.getQrCode();
    Future.delayed(
      const Duration(seconds: 2),
      (() {
        if (code == null || code.isEmpty) {
          navigateToQRScreen();
        } else {
          getMediaConnectionPairing();
        }
      }),
    );
  }

  @override
  void onInit() {
    super.onInit();

    scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    startAnimations();
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
    );
    slideAnimationPositionLeftRight = Tween<Offset>(
      begin: const Offset(-0.9, 0.0),
      end: const Offset(-0.1, 0.0),
    ).animate(scaleController);
    slideAnimationPositionUpDown = Tween<Offset>(
      begin: const Offset(0.9, 0.0),
      end: const Offset(0.0, 0.9),
    ).animate(scaleController);
    scaleAnimation = Tween<double>(begin: 1, end: 20).animate(curvedAnimation);
  }
}

void navigateToQRScreen() {
  SharedPreferences.deleteQrCode();
  if (!Get.isRegistered<ScanCodeScreenController>()) {
    Get.put<ScanCodeScreenController>(ScanCodeScreenController());
  }
  Get.offNamed(Routes.scanCodeScreen);
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
      if (model.result != null && model.result!.screenCode != "") {
        if (model.result!.orientation == "") {
          Get.put<SelectOrientationScreenMobileController>(
              SelectOrientationScreenMobileController());
          Get.offNamed(Routes.selectOrientationScreenMobile);
        } else {
          if (model.result!.title == "") {
            Get.put<NameScreenMobileController>(NameScreenMobileController());
            Get.offNamed(Routes.nameScreenMobile);
          } else {
            if (model.result?.status != "Connected") {
              Get.put<AttachMediaScreenMobileController>(
                  AttachMediaScreenMobileController());
              Get.offNamed(Routes.attachMediaScreenMobile);
            } else {
              Get.put<DownloadMediaController>(DownloadMediaController());
              Get.to(const DownloadMediaView(), arguments: model.result);
            }
          }
        }
      } else {
        Get.snackbar('Success', 'Not Paired');
        navigateToQRScreen();
      }
    } else {
      navigateToQRScreen();
      throw Exception('Failed');
    }
  } catch (error) {
    navigateToQRScreen();
    throw Exception(error);
  } finally {}
}
