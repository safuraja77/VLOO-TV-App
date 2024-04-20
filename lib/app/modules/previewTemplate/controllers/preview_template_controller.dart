import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo_tv_v2/app/data/configs/app_loader.dart';
import 'package:vloo_tv_v2/app/data/configs/sizing.dart';
import 'package:vloo_tv_v2/app/data/models/template/Template_response.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';
import 'package:vloo_tv_v2/app/data/utils/strings.dart';
import 'package:vloo_tv_v2/app/data/utils/utils.dart';

class PreviewTemplateController extends GetxController
    with GetTickerProviderStateMixin {
  RxList<TemplateSingleItemModel> singleItemList =
      <TemplateSingleItemModel>[].obs;
  List<TemplateSingleItemModel> tempSingleItemList =
      <TemplateSingleItemModel>[];
  List<List<TemplateSingleItemModel>> historySingleItemList =
      <List<TemplateSingleItemModel>>[];
  int historyIndexCount = 0;

  final RxList<MediaTempModel> templateList = <MediaTempModel>[].obs;
  RxString backgroundImage = ''.obs;
  RxBool? isUnLock = true.obs;

  var currentTemplateBackgroundColor = Rx<Color>(Colors.transparent);

  final RxList<Offset> startDragOffset = <Offset>[].obs;

  @override
  void onReady() {
    getTemplateList();
    onUpdateHistoryStack();
    super.onReady();
  }

  onUpdateHistoryStack() {
    if (historySingleItemList.length >= 5) {
      // Handle only for 5 last changes
      historySingleItemList.removeAt(0);
    }

    tempSingleItemList = <TemplateSingleItemModel>[];
    tempSingleItemList.addAll(singleItemList);

    historySingleItemList.add(tempSingleItemList);
    historyIndexCount = historySingleItemList.length - 1;
    Get.forceAppUpdate();
  }

  Future<void> getTemplateList() async {
    templateList.clear();
    AppLoader.showLoader();
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer Bearer 641|ndHdnkuNcN3pqTiFdhi0VSaLFO6teAF0o0Njwe58'
    };
    var dio = Dio();
    var response = await dio.request('https://vloo.6lgx.com/api/template/get',
        options: Options(method: 'GET', headers: headers));
    try {
      TemplateResponse model = TemplateResponse.fromJson(response.data);
      if (model.status == 200 &&
          model.result != null &&
          model.result!.isNotEmpty) {
        //Portrait
        templateList.addAll(
            model.result?.where((p) => p.orientation == "Landscape")
                as Iterable<MediaTempModel>);
        templateList.refresh();
        backgroundImage.value = templateList[0].backgroundImage!;
        currentTemplateBackgroundColor.value =
            Utils.fetchColorFromStringColor(templateList[0].backgroundColor) ??
                "";

        // singleItemList.value = templateList[0].elements!;

        for (var model in singleItemList) {
          if (model.type == 'Image') {
            model.comingFrom = Strings.editElementImage;
          } else {
            if (model.type == 'Title') {
              model.comingFrom = Strings.editElementTitle;
            } else if (model.type == 'Description') {
              model.comingFrom = Strings.editElementDescription;
            } else {
              model.comingFrom = Strings.editElementPrice;
            }
          }
          model.rect = Rect.fromLTWH(
              model.xaxis!.toDouble() * 3.6.w,
              model.yaxis!.toDouble() * 3.h,
              model.width! * 3.w,
              model.height! * 3.h);
          model.width = model.width! * 2.5.w;
          model.height = model.height! * 2.5.h;
          model.isSelected = false;
          model.fontSize = (model.fontSize == 0.0) ? 14 : model.fontSize;
          model.valueLocal =
              (model.value == null || model.value?.isEmpty == true)
                  ? ''
                  : model.value;
        }
      } else {}
      AppLoader.hideLoader();
      if (kDebugMode) {
        print(model.message);
      }
    } on Exception catch (exr) {
      print(exr.toString());
      AppLoader.hideLoader();
      if (kDebugMode) {
        print(response);
      }
      rethrow;
    }
  }

  List<MediaTempModel>? fetchFilteredList(String orientation) {
    if (templateList.isNotEmpty) {
      //var list = templateList.reversed.where((p) => p.orientation == orientation);
      var list = templateList.where((p) => p.orientation == orientation);
      return list.toList();
    }
    return null;
  }
}
