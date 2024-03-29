import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/models/template/AnimatedTextWidgetModel.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';

class AnimatedTextWidgetModel {
  int? selectedTextAlignment;
  TextStyle? selectedTextStyle;
  Rx<Color>? currentTextColor;
  Rx<Color>? currentBackgroundColor;
  String? selectedEffect;
  String? fontStyle;
  TextTransitionModel? textTransitionModel;

  AnimatedTextWidgetModel({
    this.selectedTextAlignment,
    this.selectedTextStyle,
    this.currentTextColor,
    this.currentBackgroundColor,
    this.selectedEffect,
    this.textTransitionModel,
    this.fontStyle,
  });

  static AnimatedTextWidgetModel initModel() {
    return AnimatedTextWidgetModel(
      selectedTextAlignment: 1,
      selectedTextStyle: const TextStyle(),
      fontStyle: 'OpenSans',
      currentTextColor: const Color(0xffFFFFFF).obs,
      currentBackgroundColor: Colors.transparent.obs,
      selectedEffect: StaticAssets.noneIcon,
      textTransitionModel: TextTransitionModel(
          imagePath: '',
          text: 'None',
          transitionType: null,
          animationDirection: AnimationDirection.none),
    );
  }
}

enum AnimationDirection {
  none,
  appear,
  left,
  right,
  top,
  down,
  pulse,
  positionH,
  positionV,
  wiggle,
  shaking,
}
