import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/modules/video_player/bindings/video_player_binding.dart';
import 'package:vloo_tv_v2/app/modules/video_player/views/video_player_view.dart';

import '../modules/attach_media_screen_mobile/bindings/attach_media_screen_mobile_binding.dart';
import '../modules/attach_media_screen_mobile/views/attach_media_screen_mobile_view.dart';
import '../modules/name_screen_mobile/bindings/name_screen_mobile_binding.dart';
import '../modules/name_screen_mobile/views/name_screen_mobile_view.dart';
import '../modules/scan_code_screen/bindings/scan_code_screen_binding.dart';
import '../modules/scan_code_screen/views/scan_code_screen_view.dart';
import '../modules/select_orientation_screen_mobile/bindings/select_orientation_screen_mobile_binding.dart';
import '../modules/select_orientation_screen_mobile/views/select_orientation_screen_mobile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.scanCodeScreen,
      page: () => const ScanCodeScreenView(),
      binding: ScanCodeScreenBinding(),
    ),
    GetPage(
      name: _Paths.selectOrientationScreenMobile,
      page: () => const SelectOrientationScreenMobileView(),
      binding: SelectOrientationScreenMobileBinding(),
    ),
    GetPage(
      name: _Paths.nameScreenMobile,
      page: () => const NameScreenMobileView(),
      binding: NameScreenMobileBinding(),
    ),
    GetPage(
      name: _Paths.attachMediaScreenMobile,
      page: () => const AttachMediaScreenMobileView(),
      binding: AttachMediaScreenMobileBinding(),
    ),
     GetPage(
      name: _Paths.VIDEO_PLAYER,
      page: () => const VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
  ];
}
