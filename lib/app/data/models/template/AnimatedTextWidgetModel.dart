import 'package:vloo_tv_v2/app/data/models/template/ImageModel.dart';
import 'package:vloo_tv_v2/app/data/models/template/TextTransitionModel.dart';

class TextTransitionModel {
  String? imagePath;
  String? text;
  TransitionType? transitionType;
  AnimationDirection? animationDirection;
  String? positionDirection;
  ImageTransitionsAndMoves? imageTransitionsAndMoves;

  TextTransitionModel({
    required this.imagePath,
    required this.text,
    this.transitionType,
    this.animationDirection,
    this.positionDirection,
    this.imageTransitionsAndMoves,
  });
}

enum TransitionType {
  none,
  scale,
  opacity,
  slide,
  rotation,
}
