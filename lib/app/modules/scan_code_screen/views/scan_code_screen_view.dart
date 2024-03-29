import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/configs/text.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';

import '../controllers/scan_code_screen_controller.dart';

class ScanCodeScreenView extends GetView<ScanCodeScreenController> {
  const ScanCodeScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Obx(
        () => Container(
          margin: EdgeInsets.only(
              left: 100.w, right: 100.w, top: 40.h, bottom: 25.h),
          width: Get.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/add_screen.png"),
                  Text(
                    Strings.synchronizationTheScreen,
                    style: CustomTextStyle.font22R.copyWith(
                        color: AppColor.appSkyBlue,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: Strings.onTheVlooMobileApplication,
                      style: CustomTextStyle.font22R
                          .copyWith(color: AppColor.appLightBlue),
                      children: [
                        TextSpan(
                            text: Strings.myScreens,
                            style: CustomTextStyle.font22R.copyWith(
                                color: AppColor.appLightBlue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: Strings.sectionThen,
                            style: CustomTextStyle.font22R
                                .copyWith(color: AppColor.appLightBlue)),
                        TextSpan(
                            text: Strings.addScreen,
                            style: CustomTextStyle.font22R.copyWith(
                                color: AppColor.appLightBlue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: Strings.andColon,
                            style: CustomTextStyle.font22R
                                .copyWith(color: AppColor.appLightBlue)),
                      ])),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        Strings.scanQrCode,
                        style: CustomTextStyle.font18R.copyWith(
                            color: AppColor.appLightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.h),
                      controller.getBase64ToImage(),
                    ],
                  ),
                  SizedBox(width: 30.w),
                  Column(
                    children: [
                      Text(Strings.or,
                          style: CustomTextStyle.font18R
                              .copyWith(color: AppColor.appLightBlue)),
                      SizedBox(height: 15.h),
                      Image.asset(
                        "assets/images/line.png",
                        height: 230.h,
                      ),
                    ],
                  ),
                  SizedBox(width: 30.w),
                  Column(
                    children: [
                      Text(
                        Strings.enterNumberBelow,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.font18R.copyWith(
                          color: AppColor.appLightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      controller.qrCode.isNotEmpty
                          ? Text(
                              controller.qrCode.value,
                              style: CustomTextStyle.font20R.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            )
                          : const CircularProgressIndicator(),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
