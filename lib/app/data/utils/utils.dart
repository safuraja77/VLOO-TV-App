import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/widgets/customDialog.dart';

import 'static_assets.dart';

class Utils {
  static Future<DateTime?> getDate(
      BuildContext context, DateTime endDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1910, 1),
        lastDate: endDate);

    return picked;
  }

  static Widget getNetworkImage(String endPoint,
      [BoxFit? fit, double? width, double? height]) {
    return CachedNetworkImage(
      imageUrl: endPoint,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Container(
          color: AppColor.white,
          child: Image.asset(
            StaticAssets.imageLoaderIcon,
            fit: BoxFit.scaleDown,
            width: width,
            height: height,
          )),
      errorWidget: (context, url, error) => Container(
        color: AppColor.white,
        child: Image.asset(
          StaticAssets.noImageIcon,
          fit: BoxFit.scaleDown,
          width: width,
          height: height,
        ),
      ),
    );
  }

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }

  static fetchMaterialColorFromStringColor(String? color) {
    if (color != null && color.isNotEmpty && color != "0x0" && color != "0") {
      return Utils.getMaterialColor(Color(int.parse(
              color.replaceAll("#", "").replaceFirst("0x", ""),
              radix: 16) +
          0xFF000000));
    } else {
      return getMaterialColor(AppColor.transparent);
    }
  }

  static fetchColorFromStringColor(String? color) {
    if (color != null && color.isNotEmpty && color != "0x0" && color != "0") {
      return Color(int.parse(color.replaceAll("#", "").replaceFirst("0x", ""),
              radix: 16) +
          0xFF000000);
    } else {
      return AppColor.transparent;
    }
  }

  static alertDialogBox(
      {required BuildContext context,
      String? description,
      String? pText,
      String? nText,
      required Function() onPressedPositive,
      required Function() onPressedNegative}) {
    showDialog(
      context: context,
      barrierColor: AppColor.primaryColor.withOpacity(0.9),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.transparent,
          child: CustomDialog(
              description: description,
              positiveText: pText ?? 'Yes',
              negativeText: nText ?? 'No',
              onPressedNegative: onPressedNegative,
              onPressedPositive: onPressedPositive),
        );
      },
    );
  }

  static SnackBar getSnackBar(int type, String message) {
    /* Type == 1 -> Normal info bar
    Type == 2 -> Success bar
    Type == 3 -> Error bar*/

    Color color = AppColor.unselectedTab;
    if (type == 1) {
      color = AppColor.unselectedTab;
    } else if (type == 2) {
      color = AppColor.statusGreen;
    } else if (type == 3) {
      color = AppColor.statusRed;
    }

    return SnackBar(
        showCloseIcon: true,
        closeIconColor: AppColor.white,
        backgroundColor: color,
        content: Text(message));
  }
}
