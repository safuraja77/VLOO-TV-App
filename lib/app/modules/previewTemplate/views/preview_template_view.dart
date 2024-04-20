import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
import 'package:vloo_tv_v2/app/modules/previewTemplate/controllers/preview_template_controller.dart';

import 'resize.dart';

class PreviewTemplateView extends GetView<PreviewTemplateController> {
  const PreviewTemplateView({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        // child: Transform.rotate(
        // angle:  270 * (3.1415926535897932 / 1),
        child: AspectRatio(
          aspectRatio: 16.w / 9.h,
          child: Obx(() => Container(
                color: Colors.white,
                child: DragAndResizeWidget(
                    singleItemList: controller.singleItemList.value,
                    startDragOffset: controller.startDragOffset.value,
                    backgroundImage: controller.backgroundImage.value,
                    isBottomSheetLocked: false,
                    selectedTemplateBackGroundColor:
                        controller.currentTemplateBackgroundColor.value,
                    orientation: Strings.landscape,
                    callBack: (list) {}),
              )),
        ),
      ),
      // ),
    );
  }
}
