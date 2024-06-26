import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';

/// status : 200
/// message : "All Template Records"
/// result : [{"id":3,"user_id":1,"title":"Hello 8","feature_img":"https://vloo.6lgx.com/storage/images/templates/0_1689852693.jpg","currency":"$","currency_alignment":"Middle","description":"Hello sixlogics","background_color":"","background_image":"","orientation":"Portrait","is_locked":"Yes","created_at":"2023-07-20T11:31:33.000000Z","updated_at":"2023-07-20T11:31:33.000000Z","elements":[]},{"id":4,"user_id":1,"title":"Hello 8","feature_img":"https://vloo.6lgx.com/storage/images/templates/0_1689852980.jpg","currency":"$","currency_alignment":"Middle","description":"Hello sixlogics","background_color":"","background_image":"","orientation":"Portrait","is_locked":"Yes","created_at":"2023-07-20T11:36:20.000000Z","updated_at":"2023-07-20T11:36:20.000000Z","elements":[]}]

class TemplateResponse {
  TemplateResponse({
    num? status,
    String? message,
    List<MediaTempModel>? result,
  }) {
    status = status;
    message = message;
    result = result;
  }

  TemplateResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(MediaTempModel.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<MediaTempModel>? result;
  TemplateResponse copyWith({
    num? status,
    String? message,
    List<MediaTempModel>? result,
  }) =>
      TemplateResponse(
        status: status ?? status,
        message: message ?? message,
        result: result ?? result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
