import 'package:vloo_tv_v2/app/data/models/template/template_model.dart';

class PairingResult {
  final num? id;
  final num? userId;
  final String? title;
  final String? dateOfFirstConnection;
  final String? orientation;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? screenCode;
  final List<MediaTempModel>? uploadMedias;
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

  PairingResult copyWith({
    num? id,
    num? userId,
    String? title,
    String? dateOfFirstConnection,
    String? orientation,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? screenCode,
    List<MediaTempModel>? uploadMedias,
  }) {
    return PairingResult(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      dateOfFirstConnection:
          dateOfFirstConnection ?? this.dateOfFirstConnection,
      orientation: orientation ?? this.orientation,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      screenCode: screenCode ?? this.screenCode,
      uploadMedias: uploadMedias ?? this.uploadMedias,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'date_of_first_connection': dateOfFirstConnection,
      'orientation': orientation,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'screen_code': screenCode,
      'uploadMedias': uploadMedias!.map((x) => x.toJson()).toList(),
    };
  }

  factory PairingResult.fromJson(Map<String, dynamic> json) {
    return PairingResult(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      dateOfFirstConnection: json['date_of_first_connection'],
      orientation: json['orientation'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      screenCode: json['screen_code'],
      uploadMedias: (json['uploadMedias'] as List<dynamic>?)
          ?.map((e) => MediaTempModel.fromJson(e))
          .toList(),
    );
  }
}
