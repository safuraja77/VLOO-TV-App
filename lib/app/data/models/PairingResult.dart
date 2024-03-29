import 'package:vloo_tv_v2/app/data/models/MediaModel.dart';

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
        uploadMedias?.add(MediaModel.fromJson(v));
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
  List<MediaModel>? uploadMedias;

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

//{"status":true,"message":"Screen Details","result":{"id":101,"user_id":16,"title":"qqww","date_of_first_connection":"2023-11-27","orientation":"Portrait Left","status":"Connected","created_at":"2023-11-27T14:01:06.000000Z","updated_at":"2023-11-27T14:01:52.000000Z","screen_code":"1nRrgK","uploadMedias":[{"id":56,"user_id":16,"name":"scaled_images","url":"https://vloo.6lgx.com/media/user_16/scaled_images_1700224735.jpg","type":"Image","format":"jpg","resolution":"162x311","duration":"","filesize":"5.26 KB","created_at":"2023-11-17T12:38:55.000000Z","updated_at":"2023-11-17T12:38:55.000000Z","thumbnail":"https://vloo.6lgx.com/media/user_16/scaled_images_1700224735.jpg","pivot":{"screen_id":101,"screen_contentable_id":56,"screen_contentable_type":"App\\Models\\UploadMedia"}}]}}