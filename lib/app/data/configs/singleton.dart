import 'dart:ui';

import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/models/error/error_response.dart';

class Singleton {
  static String token = "";
  static Map<String, String> header = {
    "Authorization":
        "Bearer $token" /*, "Content-Type": "application/json", "Accept": "application/json",*/
  };
  static ErrorResponse? errorResponse = ErrorResponse();

  static String? email;
  static num? code;

  static RxBool isAPILoading = false.obs;

  // Templates create
  static RxString orientation = "".obs;
  static RxString? currency = "".obs;
  static Rx<Locale> localeValue = const Locale("en").obs;

  static String comingFrom = "";
}
