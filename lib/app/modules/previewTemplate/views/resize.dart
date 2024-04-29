import 'package:animate_do/animate_do.dart';
import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glitcheffect/glitcheffect.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:spring/spring.dart';
import 'package:text_neon_widget/text_neon_widget.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/configs/text.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';
import 'package:vloo_tv_v2/app/modules/previewTemplate/views/circular_label.dart';

import 'rectangle_label.dart';
import 'rectangle_label_rounded.dart';

// ignore: must_be_immutable
class DragAndResizeWidget extends StatefulWidget {
  DownloadMediaController templatesController =
      Get.put<DownloadMediaController>(DownloadMediaController());

  final List<TemplateSingleItemModel> singleItemList;
  final bool isBottomSheetLocked;

  List<Offset>? startDragOffset = [];
  final Function(List<TemplateSingleItemModel>) callBack;
  String? backgroundImage = '';
  String orientation = '';
  Color? selectedTemplateBackGroundColor = Colors.transparent;

  bool isDraggable = true;
  late IconData iconData;
  double resizeElement = 2.0;

  DragAndResizeWidget(
      {super.key,
      required this.isBottomSheetLocked,
      required this.singleItemList,
      required this.callBack,
      this.backgroundImage,
      this.selectedTemplateBackGroundColor,
      required this.orientation,
      this.startDragOffset});

  @override
  State<DragAndResizeWidget> createState() => _DragAndResizeWidgetState();
}

class _DragAndResizeWidgetState extends State<DragAndResizeWidget> {
  // void setSingleItemList() async {
  //   await Future.delayed(Duration.zero);
  //   if (MediaQuery.of(context).size.width.isLowerThan(428)) {
  //     for (var item in widget.singleItemList) {
  //       item.rect = Rect.fromLTWH(item.rect!.left * 1.2.w, item.rect!.top * 1.h,
  //           item.width! * 0.7.w, item.height! * 0.7.w);
  //       item.width = item.width! * 0.7.w;
  //       item.height = item.height! * 0.7.w;
  //     }
  //     setState(() {});
  //   } else if (MediaQuery.of(context).size.width.isLowerThan(390)) {
  //     for (var item in widget.singleItemList) {
  //       item.rect = Rect.fromLTWH(item.rect!.left * 1.3.w,
  //           item.rect!.top * 1.1.h, item.width! * 0.8.w, item.height! * 0.8.w);
  //       item.width = item.width! * 1.w;
  //       item.height = item.height! * 1.h;
  //     }
  //     setState(() {});
  //   } else if (MediaQuery.of(context).size.width.isGreaterThan(900)) {
  //     for (var item in widget.singleItemList) {
  //       item.rect = Rect.fromLTWH(item.rect!.left * 10.w, item.rect!.top * 7.h,
  //           item.width! * 1.w, item.height! * 1.w);
  //       item.width = item.width! * 1.w;
  //       item.height = item.height! * 1.h;
  //     }
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  Widget textWidget(TemplateSingleItemModel templateSingleItemModel) {
    // if((templateSingleItemModel.valueLocal?.length ?? 0)< 15) {
    //   return FittedBox(
    //     fit: BoxFit.cover,
    //     child: Text(templateSingleItemModel.valueLocal ?? '',
    //         textAlign: templateSingleItemModel.selectedAlignment == 0
    //             ? TextAlign.start
    //             : templateSingleItemModel.selectedAlignment == 1
    //             ? TextAlign.center
    //             : TextAlign.end,
    //         style: TextStyle(
    //           height: 1.0,
    //           fontFamily: templateSingleItemModel.fontFamily,
    //           fontSize: 2000.w,
    //           color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
    //           backgroundColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
    //         )),
    //   );
    // }else{
    return Text(templateSingleItemModel.valueLocal ?? '',
        textAlign: templateSingleItemModel.selectedAlignment == 0
            ? TextAlign.start
            : templateSingleItemModel.selectedAlignment == 1
                ? TextAlign.center
                : TextAlign.end,
        style: TextStyle(
          height: 1.0,
          fontFamily: templateSingleItemModel.fontFamily,
          fontSize: templateSingleItemModel.fontSize! * 2.8.w,
          color: Utils.fetchColorFromStringColor(
              templateSingleItemModel.textColor),
          backgroundColor: Utils.fetchColorFromStringColor(
              templateSingleItemModel.backgroundColor),
        ));
    // }
  }

  Widget appliedEffectWidget(TemplateSingleItemModel templateSingleItemModel) {
    SpringController springControllerFade =
        SpringController(initialAnim: Motion.mirror);
    SpringController springControllerBlink =
        SpringController(initialAnim: Motion.mirror);
    // Show all this effects only on preview screen
    switch (templateSingleItemModel.effect) {
      case StaticAssets.noneIcon:
        return textWidget(templateSingleItemModel);
      case StaticAssets.effectNeon:
        return PTTextNeon(
          text: templateSingleItemModel.valueLocal ?? "",
          color: Utils.fetchMaterialColorFromStringColor(
              templateSingleItemModel.textColor),
          font: templateSingleItemModel.fontFamily,
          shine: true,
          fontSize: templateSingleItemModel.fontSize! *
              3.0.w, // change everywhere in file
          strokeWidthTextHigh: 3,
          blurRadius: 5,
          strokeWidthTextLow: 1,
          backgroundColor: Utils.fetchMaterialColorFromStringColor(
              templateSingleItemModel.backgroundColor),
        );
      case StaticAssets.effectGlitch:
        return GlitchEffect(
          child: textWidget(templateSingleItemModel),
        );
      case StaticAssets.effectFade:
        return Spring.fadeOut(
            springController: springControllerFade,
            delay: const Duration(milliseconds: 1000),
            animDuration: const Duration(milliseconds: 4000),
            child: Text(
              templateSingleItemModel.valueLocal ?? "",
              style: TextStyle(
                fontFamily: templateSingleItemModel.fontFamily,
                fontSize: templateSingleItemModel.fontSize! * 10.w,
                color: Utils.fetchColorFromStringColor(
                    templateSingleItemModel.textColor),
                shadows: [
                  Shadow(
                      color: Utils.fetchColorFromStringColor(
                          templateSingleItemModel.backgroundColor),
                      blurRadius: 30,
                      offset: Offset.zero)
                ],
              ),
            ));
      case StaticAssets.effectCut:
        return Spring.blink(
          springController: springControllerBlink,
          startOpacity: 0.1, //default=0.0
          endOpacity: 0.9,
          animDuration: const Duration(milliseconds: 1500),
          child: Text(
            templateSingleItemModel.valueLocal ?? '',
            style: CustomTextStyle.font22R.copyWith(
                color: Utils.fetchColorFromStringColor(
                    templateSingleItemModel.textColor),
                fontSize: templateSingleItemModel.fontSize! * 10.w,
                fontFamily: templateSingleItemModel.fontFamily),
          ),
        );
      case StaticAssets.effectBlink:
        return FlickerNeonText(
          fontFamily: templateSingleItemModel.fontFamily,
          textColor: Utils.fetchColorFromStringColor(
              templateSingleItemModel.textColor),
          textAlign: templateSingleItemModel.selectedAlignment == 0
              ? TextAlign.start
              : templateSingleItemModel.selectedAlignment == 1
                  ? TextAlign.center
                  : TextAlign.end,
          text: templateSingleItemModel.valueLocal ?? "",
          flickerTimeInMilliSeconds: 1200,
          spreadColor: Utils.fetchColorFromStringColor(
              templateSingleItemModel.backgroundColor),
          blurRadius: 20,
          textSize: templateSingleItemModel.fontSize! * 10.w,
        );
    }

    return textWidget(templateSingleItemModel);
  }

  Widget appliedAnimationTextWidget(
      TemplateSingleItemModel templateSingleItemModel) {
    // Show all this animation only on preview screen
    switch (templateSingleItemModel.animation) {
      case 'None':
        return appliedEffectWidget(templateSingleItemModel);
      case 'Appear':
        return DefaultTextStyle(
          style: TextStyle(
            fontFamily: templateSingleItemModel.fontFamily,
            fontSize: templateSingleItemModel.fontSize! * 3.w,
            color: Utils.fetchColorFromStringColor(
                templateSingleItemModel.textColor),
            shadows: [
              Shadow(
                  color: templateSingleItemModel.comingFrom ==
                              Strings.addElementDescription ||
                          templateSingleItemModel.comingFrom ==
                              Strings.editElementDescription
                      ? AppColor.transparent
                      : Utils.fetchColorFromStringColor(
                          templateSingleItemModel.backgroundColor),
                  blurRadius: 30,
                  offset: Offset.zero)
            ],
            backgroundColor: templateSingleItemModel.comingFrom ==
                        Strings.addElementDescription ||
                    templateSingleItemModel.comingFrom ==
                        Strings.editElementDescription
                ? Utils.fetchColorFromStringColor(
                    templateSingleItemModel.backgroundColor)
                : AppColor.transparent,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                  scalingFactor: 0.8, templateSingleItemModel.valueLocal ?? ""),
            ],
            onTap: () {
              debugPrint("Tap Event");
            },
          ),
        );

      //FadedScaleAnimation(scaleDuration: const Duration(milliseconds: 1500), child: appliedEffectWidget(templateSingleItemModel));
      case 'Left':
        return SlideInAnimation(
            direction: Direction.left,
            duration: const Duration(seconds: 1),
            child: appliedEffectWidget(templateSingleItemModel));
      case 'Right':
        return SlideInAnimation(
            direction: Direction.right,
            duration: const Duration(seconds: 1),
            child: appliedEffectWidget(templateSingleItemModel));
      case 'Top':
        return SlideInAnimation(
            direction: Direction.up,
            duration: const Duration(seconds: 1),
            child: appliedEffectWidget(templateSingleItemModel));

      case 'Down':
        return SlideInAnimation(
            direction: Direction.down,
            duration: const Duration(seconds: 1),
            child: appliedEffectWidget(templateSingleItemModel));
    }

    return appliedEffectWidget(templateSingleItemModel);
  }

  Widget imageWidget(TemplateSingleItemModel templateSingleItemModel) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Utils.getNetworkImage(
            templateSingleItemModel.valueLocal ?? '',
            BoxFit.fill,
            templateSingleItemModel.width,
            templateSingleItemModel.height),
        templateSingleItemModel.availability == ''
            ? const SizedBox()
            : Center(
                child: SvgPicture.asset(
                  templateSingleItemModel.availability ?? '',
                  height: templateSingleItemModel.height!.toDouble() * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
      ],
    );
  }

  Widget appliedAnimationImageWidget(
      TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springControllerOpacity =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerLeft =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerRight =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerUp =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerBottom =
        SpringController(initialAnim: Motion.mirror);

    // Show all this effects only on preview screen
    switch (templateSingleItemModel.animation) {
      case "ImageTransitionsAndMoves.none":
        return child;
      case "ImageTransitionsAndMoves.appear":
        return Spring.opacity(
            springController: springControllerOpacity,
            startOpacity: 1.0,
            endOpacity: 0.0,
            animDuration: const Duration(seconds: 3),
            delay: const Duration(seconds: 1),
            child: child);
      case "ImageTransitionsAndMoves.left":
        return Spring.slide(
            springController: springControllerLeft,
            slideType: SlideType.slide_out_left,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(-100, 0)),
            child: child);
      case "ImageTransitionsAndMoves.right":
        return Spring.slide(
            springController: springControllerRight,
            slideType: SlideType.slide_out_right,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(100, 0)),
            child: child);
      case "ImageTransitionsAndMoves.top":
        return Spring.slide(
            springController: springControllerUp,
            slideType: SlideType.slide_out_bottom,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(0, -50)),
            child: child);
      case "ImageTransitionsAndMoves.down":
        return Spring.slide(
            springController: springControllerBottom,
            slideType: SlideType.slide_out_top,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(0, 50)),
            child: child);
    }
    return imageWidget(templateSingleItemModel);
  }

  Widget appliedAnimationPriceWidget(
      TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springControllerOpacity =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerLeft =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerRight =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerUp =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerBottom =
        SpringController(initialAnim: Motion.mirror);
    // Show all this effects only on preview screen
    switch (templateSingleItemModel.animation) {
      case "None":
        return child;
      case "Appear":
        return Spring.opacity(
            springController: springControllerOpacity,
            startOpacity: 1.0,
            endOpacity: 0.0,
            animDuration: const Duration(seconds: 3),
            delay: const Duration(seconds: 1),
            child: child);
      case "Left":
        return Spring.slide(
            springController: springControllerLeft,
            slideType: SlideType.slide_out_left,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(-100, 0)),
            child: child);
      case "Right":
        return Spring.slide(
            springController: springControllerRight,
            slideType: SlideType.slide_out_right,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(100, 0)),
            child: child);
      case "Top":
        return Spring.slide(
            springController: springControllerUp,
            slideType: SlideType.slide_out_bottom,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(0, -50)),
            child: child);
      case "Down":
        return Spring.slide(
            springController: springControllerBottom,
            slideType: SlideType.slide_out_top,
            animDuration: const Duration(seconds: 3),
            withFade: true,
            delay: const Duration(seconds: 2),
            cutomTweenOffset: Tween<Offset>(
                begin: const Offset(0, 0), end: const Offset(0, 50)),
            child: child);
    }

    return child;
  }

  Widget setPriceTheme(
      int index, TemplateSingleItemModel templateSingleItemModel) {
    if (templateSingleItemModel.valueLocal!.isNotEmpty) {
      switch (templateSingleItemModel.theme) {
        case StaticAssets.priceTheme3Icon:
          return RectangleLabel(
              text: templateSingleItemModel.valueLocal!.obs,
              textColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.rectangular);
        case StaticAssets.priceTheme2Icon:
          return CircularLabel(
              text: templateSingleItemModel.valueLocal!.obs,
              textColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.circular);
        case StaticAssets.priceTheme1Icon:
          return RectangleLabelRounded(
              text: templateSingleItemModel.valueLocal!.obs,
              textColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.textColor),
              bgColor: Utils.fetchColorFromStringColor(
                  templateSingleItemModel.backgroundColor),
              templateSingleItemModel: templateSingleItemModel,
              backgroundImage: StaticAssets.rectangularRounded);
      }
    }
    return const SizedBox();
  }

  Widget appliedMoveAnimationWidget(
      TemplateSingleItemModel templateSingleItemModel, Widget child) {
    final SpringController springController =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerScale =
        SpringController(initialAnim: Motion.mirror);
    final SpringController springControllerPositionUp =
        SpringController(initialAnim: Motion.mirror);
    Duration duration = const Duration(milliseconds: 2000);

    switch (templateSingleItemModel.effect) {
      case "ImageTransitionsAndMoves.none":
        return child;
      case "ImageTransitionsAndMoves.pulse":
        return Pulse(
            duration: const Duration(seconds: 4), infinite: true, child: child);
      case "ImageTransitionsAndMoves.positionH":
        return ShakeX(
            duration: const Duration(seconds: 4), infinite: true, child: child);
      case "ImageTransitionsAndMoves.positionV":
        return Spring.translate(
            springController: springControllerPositionUp,
            beginOffset: const Offset(0, 0),
            endOffset: const Offset(0, -25),
            animDuration: const Duration(seconds: 3),
            child: child);
      case "ImageTransitionsAndMoves.wiggle":
        return Spring.rotate(
          springController: springController,
          alignment: Alignment.center, //def=center
          startAngle: -2, //def=0
          endAngle: 2, //def=360
          delay: const Duration(milliseconds: 0),
          animDuration: duration, //def=1s
          animStatus: (AnimStatus status) {},
          curve: Curves.easeInOutBack, //def=Curves.easInOut
          child: Spring.scale(
              springController: springControllerScale,
              start: 1,
              end: 0.987,
              child: child),
        );
      case "ImageTransitionsAndMoves.shaking":
        return Spring.rotate(
          springController: springController,
          alignment: Alignment.center, //def=center
          startAngle: -6, //def=0
          endAngle: 6, //def=360
          delay: const Duration(milliseconds: 0),
          animDuration: duration, //def=1s
          animStatus: (AnimStatus status) {},
          curve: Curves.easeInOutBack, //def=Curves.easInOut
          child: child,
        );
    }

    return child;
  }

  Widget setData(TemplateSingleItemModel templateSingleItemModel, int index) {
    if (templateSingleItemModel.theme == null ||
        templateSingleItemModel.theme == '' ||
        templateSingleItemModel.theme == StaticAssets.none) {
      if (templateSingleItemModel.comingFrom == Strings.addElementImage ||
          templateSingleItemModel.comingFrom == Strings.editElementImage) {
        return Transform.rotate(
            angle: double.tryParse(templateSingleItemModel.rotation ?? "0.0") ??
                0.0,
            child: appliedAnimationImageWidget(
                templateSingleItemModel,
                appliedMoveAnimationWidget(templateSingleItemModel,
                    imageWidget(templateSingleItemModel))));
      } else {
        return Transform.rotate(
          angle:
              double.tryParse(templateSingleItemModel.rotation ?? "0.0") ?? 0.0,
          child: appliedAnimationTextWidget(templateSingleItemModel),
        );
      }
    } else {
      return Transform.rotate(
          angle:
              double.tryParse(templateSingleItemModel.rotation ?? "0.0") ?? 0.0,
          child: appliedAnimationPriceWidget(templateSingleItemModel,
              setPriceTheme(index, templateSingleItemModel)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
          decoration: BoxDecoration(
            color: widget.selectedTemplateBackGroundColor,
            border: Border.all(
              color: widget.templatesController.isUnLock?.value == true
                  ? AppColor.appLightBlue
                  : AppColor.red,
              width: 0.5,
            ),
            image: widget.backgroundImage == ""
                ? null
                : DecorationImage(
                    image: NetworkImage(widget.backgroundImage ?? ''),
                    fit: BoxFit.cover),
          ),
          child: Stack(
              children: List.generate(
            widget.singleItemList.length,
            (index) => TransformableBox(
              allowContentFlipping: false,
              debugPaintHandleBounds: true,
              resizable: widget.singleItemList[index].isSelected ?? false,
              draggable: widget.singleItemList[index].isSelected ?? true,
              rect: widget.singleItemList[index].rect,
              enabledHandles: const {HandlePosition.bottomRight},
              visibleHandles: const {
                ...HandlePosition.values,
              },
              onChanged: (result, event) {
                setState(() {
                  widget.singleItemList[index].rect = result.rect;
                  widget.singleItemList[index].xaxis = result.rect.left;
                  widget.singleItemList[index].yaxis = result.rect.top;
                  widget.singleItemList[index].height = result.rect.height;
                  widget.singleItemList[index].width = result.rect.width;
                });
              },
              contentBuilder: (BuildContext context, Rect rect, Flip flip) {
                return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: widget.singleItemList[index].isSelected == true
                          ? Border.all(color: AppColor.appSkyBlue, width: 2)
                          : null,
                    ),
                    child: setData(widget.singleItemList[index], index));
              },
            ),
          ))),
    );
  }
}
