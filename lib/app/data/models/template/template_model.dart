import 'package:vloo_tv_v2/app/data/models/template/template_single_item_model.dart';

class MediaTempModel {
  final int id;
  final int userId;
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
  List<TemplateSingleItemModel>? elements;

  MediaTempModel({
    required this.id,
    required this.userId,
    this.title,
    required this.featureImg,
    required this.currency,
    required this.currencyAlignment,
    required this.description,
    required this.backgroundColor,
    required this.backgroundImage,
    required this.orientation,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.status,
    required this.isLive,
    required this.isPredefined,
    required this.isTemplate,
    this.url,
    this.type,
    this.format,
    this.resolution,
    this.duration,
    this.filesize,
    this.thumbnail,
    this.localUrl,
    this.elements,
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
      'elements': elements?.map((e) => e.toJson()).toList(),
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
      elements: (json['elements'] as List<dynamic>?)
          ?.map((e) => TemplateSingleItemModel.fromJson(e))
          .toList(),
    );
  }
}
