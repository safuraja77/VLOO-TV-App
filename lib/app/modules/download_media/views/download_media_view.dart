import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/configs/text.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';

import '../controllers/download_media_controller.dart';

class DownloadMediaView extends GetView<DownloadMediaController> {
  const DownloadMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
          width: Get.width,
          child: Column(
            children: [
              SvgPicture.asset(StaticAssets.splashLogo,
                  width: 150.w, height: 150.h),
              SizedBox(height: 20.h),
              Image.asset('assets/images/happy.gif',
                  width: 200.w, height: 200.h),
              SizedBox(height: 20.h),
              Text(
                // Strings.pleaseWaitForStream,
                controller.pairingResult!.orientation!,
                textAlign: TextAlign.center,
                style: CustomTextStyle.font20R.copyWith(
                  color: AppColor.appLightBlue.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
