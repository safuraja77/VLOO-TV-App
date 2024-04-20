import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/modules/previewTemplate/controllers/preview_template_controller.dart';

class RectangleLabelRounded extends GetView<PreviewTemplateController> {
  final String backgroundImage;
  RxString text = ''.obs;
  final TextStyle? labelStyle;
  final Color? bgColor;
  final Color? textColor;
  final TemplateSingleItemModel? templateSingleItemModel;

  RectangleLabelRounded(
      {super.key,
      required this.backgroundImage,
      required this.text,
      this.labelStyle,
      this.templateSingleItemModel,
      this.bgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(backgroundImage,
            colorFilter: ColorFilter.mode(
                bgColor == Colors.transparent
                    ? Colors.red
                    : bgColor ?? Colors.red,
                BlendMode.srcIn),
            width: templateSingleItemModel?.width,
            height: templateSingleItemModel?.height,
            fit: BoxFit.contain),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: 6.1,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: RichText(
                    text: TextSpan(
                        style: labelStyle ??
                            TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    templateSingleItemModel?.fontSize! != null
                                        ? (templateSingleItemModel!.fontSize! +
                                            10.0)
                                        : 30.sp,
                                fontStyle: FontStyle.italic,
                                color: textColor ?? Colors.white),
                        children: [
                          TextSpan(
                            text: text.value,
                          ),
                          WidgetSpan(
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: textColor ?? Colors.white,
                                  fontSize:
                                      templateSingleItemModel?.fontSize! != null
                                          ? (templateSingleItemModel!
                                                  .fontSize! +
                                              10.0)
                                          : 30.sp,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
