import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';
import 'package:vloo_tv_v2/app/modules/previewTemplate/controllers/preview_template_controller.dart';

class CircularLabel extends GetView<DownloadMediaController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  CircularLabel(
      {super.key,
      this.labelStyle,
      required this.text,
      required this.backgroundImage,
      this.templateSingleItemModel,
      this.bgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            width: templateSingleItemModel?.width,
            height: templateSingleItemModel?.height,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            fit: BoxFit.contain),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.value.split('.').first,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: (templateSingleItemModel?.fontSize ??
                            27 /
                                (text.value.length == 1
                                    ? text.value.length * 0.6
                                    : text.value.length * 0.4))
                        .sp,
                    fontStyle: FontStyle.italic,
                    color: textColor ?? Colors.white)),
            if (text.value.contains('.')) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text('£',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:
                            (templateSingleItemModel?.fontSize ?? 30 / 3.5).sp,
                        fontStyle: FontStyle.italic,
                        color: textColor ?? Colors.white)),
              ),
              Text(text.value.split('.').last,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize:
                          (templateSingleItemModel?.fontSize ?? 30 / 2).sp,
                      fontStyle: FontStyle.italic,
                      color: textColor ?? Colors.white))
            ]
          ],
        ),
      ],
    );
  }
}
