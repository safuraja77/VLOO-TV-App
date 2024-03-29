import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/configs/text.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';

import '../controllers/name_screen_mobile_controller.dart';

class NameScreenMobileView extends GetView<NameScreenMobileController> {
  const NameScreenMobileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(StaticAssets.splashLogo,
                width: 150.w, height: 150.h),
            SizedBox(height: 20.h),
            Text(
              Strings.almostThereLastStep,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font22R
                  .copyWith(color: AppColor.appLightBlue),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  StaticAssets.icInfo,
                  width: 38.w,
                  height: 38.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  Strings.stepNecessary,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.font20R
                      .copyWith(color: AppColor.appSkyBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
