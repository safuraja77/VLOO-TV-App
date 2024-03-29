import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo_tv_v2/app/data/configs/app_theme.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/utils/static_assets.dart';
import 'package:vloo_tv_v2/app/data/widgets/custom_buttons.dart';

class CustomDialog extends StatelessWidget {
  final String? description;
  final String positiveText;
  final String negativeText;
  final Function() onPressedPositive;
  final Function() onPressedNegative;

  const CustomDialog(
      {super.key,
      this.description,
      required this.positiveText,
      required this.negativeText,
      required this.onPressedPositive,
      required this.onPressedNegative});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: Container(
          width: 400.0,
          // Set the desired width
          height: 360.0.h,
          // Set the desired height
          padding: EdgeInsets.symmetric(vertical: 40.h),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.5),
            border: Border.all(width: 1, color: AppColor.appLightBlue),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SvgPicture.asset(
              StaticAssets.splashLogo,
              height: 60,
              width: 150.w,
            ),
            SizedBox(height: 25.h),
            Text(
              description ??
                  'Would you like to start automatically \nthe Vloo Player app each time \nstart this device?',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColor.appLightBlue,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (negativeText.isNotEmpty) ...[
                  TextButton(
                    onPressed: onPressedNegative,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: CustomButton(
                      buttonName: negativeText,
                      borderColor: AppColor.appLightBlue,
                      width: 130.w,
                      height: 50.h,
                      isbold: true,
                      textSize: 12,
                      color: AppColor.appLightBlue,
                    ),
                  ),
                  SizedBox(width: 50.w),
                ],
                TextButton(
                  onPressed: onPressedPositive,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: CustomButton(
                    buttonName: positiveText,
                    backgroundColor: AppColor.appSkyBlue,
                    width: 130.w,
                    height: 50.h,
                    isbold: true,
                    textSize: 12,
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
