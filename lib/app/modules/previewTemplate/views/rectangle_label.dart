import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/modules/download_media/controllers/download_media_controller.dart';

class RectangleLabel extends GetView<DownloadMediaController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final TemplateSingleItemModel? templateSingleItemModel;
  final Color? textColor;

  RectangleLabel(
      {super.key,
      required this.text,
      this.labelStyle,
      required this.backgroundImage,
      this.templateSingleItemModel,
      this.bgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          backgroundImage,
          colorFilter: ColorFilter.mode(
              bgColor == Colors.transparent
                  ? Colors.amber
                  : bgColor ?? Colors.amber,
              BlendMode.srcIn),
          fit: BoxFit.contain,
          width: templateSingleItemModel?.width,
          height: templateSingleItemModel?.height,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child: RichText(
                  text: TextSpan(
                      text: text.value.split('.').first,
                      style: labelStyle?.copyWith(color: textColor) ??
                          TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: templateSingleItemModel?.fontSize! !=
                                      null
                                  ? (templateSingleItemModel!.fontSize! + 10.0)
                                  : (50 - (text.value.length * 5)).sp,
                              fontStyle: FontStyle.italic,
                              color: textColor ?? Colors.black),
                      children: [
                        if (text.contains('.'))
                          WidgetSpan(
                              child: Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Row(
                              children: [
                                Text('£',
                                    style: labelStyle?.copyWith(
                                            color: textColor ?? Colors.black) ??
                                        TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: (templateSingleItemModel
                                                    ?.fontSize ??
                                                10 / 1.2),
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black)),
                                Text(text.split('.').last,
                                    style: labelStyle?.copyWith(
                                            color: textColor ?? Colors.black) ??
                                        TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: (templateSingleItemModel
                                                    ?.fontSize ??
                                                10 / 1.2),
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black)),
                              ],
                            ),
                          )),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
