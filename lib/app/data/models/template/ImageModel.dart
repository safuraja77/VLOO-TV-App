class ImageModel {
  String? image;
  String? sticker;
  ImageTransitionsAndMoves? imageTransition = ImageTransitionsAndMoves.none;
  ImageTransitionsAndMoves? imageMove = ImageTransitionsAndMoves.none;
  ImageModel({
    this.image,
    this.sticker,
    this.imageTransition,
    this.imageMove,
  });

  static ImageModel initModel() {
    return ImageModel(image: '', sticker: '');
  }
}
enum ImageTransitionsAndMoves { none, appear, left, right, top, down, pulse, positionH, positionV, wiggle, shaking }
