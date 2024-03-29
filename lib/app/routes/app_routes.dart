part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const scanCodeScreen = _Paths.scanCodeScreen;
  static const selectOrientationScreenMobile =
      _Paths.selectOrientationScreenMobile;
  static const nameScreenMobile = _Paths.nameScreenMobile;
  static const attachMediaScreenMobile = _Paths.attachMediaScreenMobile;
  static const mediaPlayer = _Paths.mediaPlayer;
  static const downloadMedia = _Paths.downloadMedia;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const scanCodeScreen = '/scan-code-screen';
  static const selectOrientationScreenMobile =
      '/select-orientation-screen-mobile';
  static const nameScreenMobile = '/name-screen-mobile';
  static const attachMediaScreenMobile = '/attach-media-screen-mobile';
  static const mediaPlayer = '/media-player';
  static const downloadMedia = '/download-media';
}
