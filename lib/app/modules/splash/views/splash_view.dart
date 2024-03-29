

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        color: AppColor.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.5),
                end: const Offset(0.0, 0.0),
              ).animate(controller.scaleController),
              child: SvgPicture.asset(
                StaticAssets.vlooLogo,
                width: 80.w,
                height: 80.h,
              ),
            ),
            const SizedBox(height: 10),
            AnimatedCrossFade(
              crossFadeState: CrossFadeState.showSecond,
              firstChild: const SizedBox(),
              duration: const Duration(seconds: 1),
              secondChild: SvgPicture.asset(
                StaticAssets.icSlogan,
                width: 40.w,
                height: 40.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
