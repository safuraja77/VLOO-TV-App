// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vloo_tv_v2/app/data/models/MediaModel.dart';

class MediaTempModel {
  final String? screenTitle;
  final String? order;
  final String? isTemplate;
  final List<MediaModel>? media;
  MediaTempModel({
    this.screenTitle,
    this.order,
    this.isTemplate,
    this.media,
  });

  MediaTempModel copyWith({
    String? screenTitle,
    String? order,
    String? isTemplate,
    List<MediaModel>? media,
  }) {
    return MediaTempModel(
      screenTitle: screenTitle ?? this.screenTitle,
      order: order ?? this.order,
      isTemplate: isTemplate ?? this.isTemplate,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'screenTitle': screenTitle,
      'order': order,
      'isTemplate': isTemplate,
      'media': media!.map((x) => x.toJson()).toList(),
    };
  }

  factory MediaTempModel.fromMap(Map<String, dynamic> map) {
    return MediaTempModel(
      screenTitle: map['screenTitle'] as String,
      order: map['order'] as String,
      isTemplate: map['isTemplate'] as String,
      media: map['media'] != null
          ? List<MediaModel>.from(
              (map['media'] as List<int>).map<MediaModel?>(
                (x) => MediaModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaTempModel.fromJson(String source) =>
      MediaTempModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaTempModel(screenTitle: $screenTitle, order: $order, isTemplate: $isTemplate, media: $media)';
  }

  @override
  bool operator ==(covariant MediaTempModel other) {
    if (identical(this, other)) return true;

    return other.screenTitle == screenTitle &&
        other.order == order &&
        other.isTemplate == isTemplate &&
        listEquals(other.media, media);
  }

  @override
  int get hashCode {
    return screenTitle.hashCode ^
        order.hashCode ^
        isTemplate.hashCode ^
        media.hashCode;
  }
}
