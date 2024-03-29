import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/configs/text.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';

import '../controllers/attach_media_screen_mobile_controller.dart';

class AttachMediaScreenMobileView
    extends GetView<AttachMediaScreenMobileController> {
  const AttachMediaScreenMobileView({super.key});
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
              Image.asset('assets/images/star.gif'),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: AppColor.primaryGreen),
                  SizedBox(width: 10.w),
                  Text(
                    Strings.screenInstalled,
                    style: CustomTextStyle.font22R.copyWith(
                        color: AppColor.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp),
                  ),
                ],
              ),
              Text(
                Strings.projectReadyToDisplay,
                textAlign: TextAlign.center,
                style: CustomTextStyle.font20R
                    .copyWith(color: AppColor.appLightBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
