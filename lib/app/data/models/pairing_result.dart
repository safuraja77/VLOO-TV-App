import 'package:vloo_tv_v2/app/data/models/media_model.dart';
import 'package:vloo_tv_v2/app/data/models/template/template.dart';

class PairingResult {
  PairingResult({
    this.id,
    this.userId,
    this.title,
    this.dateOfFirstConnection,
    this.orientation,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.screenCode,
    this.uploadMedias,
  });

  PairingResult.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    dateOfFirstConnection = json['date_of_first_connection'];
    orientation = json['orientation'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    screenCode = json['screen_code'];
    if (json['uploadMedias'] != null) {
      uploadMedias = [];
      json['uploadMedias'].forEach((v) {
        if (v['is_template'] == true) {
          uploadMedias?.add(TemplatesModel.fromJson(v));
        } else {
          uploadMedias?.add(MediaModel.fromMap(v));
        }
      });
    }
  }
  num? id;
  num? userId;
  String? title;
  String? dateOfFirstConnection;
  String? orientation;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? screenCode;
  List<dynamic>? uploadMedias;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['date_of_first_connection'] = dateOfFirstConnection;
    map['orientation'] = orientation;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['screen_code'] = screenCode;
    if (uploadMedias != null) {
      map['uploadMedias'] = uploadMedias?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
