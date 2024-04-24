// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';

class MediaTempModel {
  final int? id;
  final int? userId;
  final String? title;
  final String? featureImg;
  final String? currency;
  final String? currencyAlignment;
  final String? description;
  final String? backgroundColor;
  final String? backgroundImage;
  final String? orientation;
  final String? isLocked;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? status;
  final String? isLive;
  final int? isPredefined;
  final bool? isTemplate;
  String? url;
  final String? type;
  final String? format;
  final String? resolution;
  final String? duration;
  final String? filesize;
  final String? thumbnail;
  String? localUrl;
  final List<TemplateSingleItemModel>? templateElements;

  MediaTempModel({
    this.id,
    this.userId,
    this.title,
    this.featureImg,
    this.currency,
    this.currencyAlignment,
    this.description,
    this.backgroundColor,
    this.backgroundImage,
    this.orientation,
    this.isLocked,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.status,
    this.isLive,
    this.isPredefined,
    this.isTemplate,
    this.url,
    this.type,
    this.format,
    this.resolution,
    this.duration,
    this.filesize,
    this.thumbnail,
    this.localUrl,
    this.templateElements,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'title': title,
      'feature_img': featureImg,
      'currency': currency,
      'currency_alignment': currencyAlignment,
      'description': description,
      'background_color': backgroundColor,
      'background_image': backgroundImage,
      'orientation': orientation,
      'is_locked': isLocked,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'status': status,
      'is_live': isLive,
      'is_predefined': isPredefined,
      'is_template': isTemplate,
      'url': url,
      'type': type,
      'format': format,
      'resolution': resolution,
      'duration': duration,
      'filesize': filesize,
      'thumbnail': thumbnail,
      'localUrl': localUrl,
      // 'template_elements': templateElements?.map((e) => e.toJson()).toList(),
    };
  }

  factory MediaTempModel.fromJson(dynamic json) {
    return MediaTempModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      featureImg: json['feature_img'],
      currency: json['currency'],
      currencyAlignment: json['currency_alignment'],
      description: json['description'],
      backgroundColor: json['background_color'],
      backgroundImage: json['background_image'],
      orientation: json['orientation'],
      isLocked: json['is_locked'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      status: json['status'],
      isLive: json['is_live'],
      isPredefined: json['is_predefined'],
      isTemplate: json['is_template'],
      url: json['url'],
      type: json['type'],
      format: json['format'],
      resolution: json['resolution'],
      duration: json['duration'],
      filesize: json['filesize'],
      thumbnail: json['thumbnail'],
      localUrl: json['loalUrl'],
      templateElements: json['template_elements'] != null
          ? (json['template_elements'] as List<dynamic>?)
              ?.map((e) => TemplateSingleItemModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
