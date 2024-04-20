part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const scanCodeScreen = _Paths.scanCodeScreen;
  static const selectOrientationScreenMobile =
      _Paths.selectOrientationScreenMobile;
  static const nameScreenMobile = _Paths.nameScreenMobile;
  static const attachMediaScreenMobile = _Paths.attachMediaScreenMobile;
  static const downloadMedia = _Paths.downloadMedia;
  static const VIDEO_PLAYER = _Paths.VIDEO_PLAYER;
  static const templates = _Paths.templates;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const scanCodeScreen = '/scan-code-screen';
  static const selectOrientationScreenMobile =
      '/select-orientation-screen-mobile';
  static const nameScreenMobile = '/name-screen-mobile';
  static const attachMediaScreenMobile = '/attach-media-screen-mobile';
  static const downloadMedia = '/download-media';
  static const VIDEO_PLAYER = '/video-player';
  static const templates = '/preview-template';
}
