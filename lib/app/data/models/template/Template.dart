// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';

// import 'dart:ui';

// import 'template_single_item_model.dart';

// /// id : 3
// /// user_id : 1
// /// title : "Hello 8"
// /// feature_img : "https://vloo.6lgx.com/storage/images/templates/0_1689852693.jpg"
// /// currency : "$"
// /// currency_alignment : "Middle"
// /// description : "Hello sixlogics"
// /// background_color : ""
// /// background_image : ""
// /// orientation : "Portrait"
// /// is_locked : "Yes"
// /// created_at : "2023-07-20T11:31:33.000000Z"
// /// updated_at : "2023-07-20T11:31:33.000000Z"
// /// elements : []

// class Template {
//   Template({
//     int? id,
//       num? userId,
//       String? title,
//       String? name,
//       String? featureImg,
//       String? currency,
//       String? currencyAlignment,
//       String? description,
//       String? backgroundColor,
//       String? backgroundImage,
//       String? orientation,
//       String? isLocked,
//       int? isPredefined,
//       String? createdAt,
//       String? updatedAt,
//       List<TemplateSingleItemModel>? elements,}){
//     id = id;
//     userId = userId;
//     title = title;
//     name = name;
//     featureImg = featureImg;
//     currency = currency;
//     currencyAlignment = currencyAlignment;
//     description = description;
//     backgroundColor = backgroundColor;
//     backgroundImage = backgroundImage;
//     orientation = orientation;
//     isLocked = isLocked;
//     isPredefined =isPredefined;
//     createdAt = createdAt;
//     updatedAt = updatedAt;
//     elements = elements;
// }

//   Template.fromJson(dynamic json) {
//     id = json['id'];
//     userId = json['user_id'];
//     title = json['title'];
//     name = json['name'];
//     featureImg = json['feature_img'];
//     currency = json['currency'];
//     currencyAlignment = json['currency_alignment'];
//     description = json['description'];
//     backgroundColor = json['background_color'];
//     backgroundImage = json['background_image'];
//     orientation = json['orientation'];
//     isLocked = json['is_locked'];
//     isPredefined = json['is_predefined'] ;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['template_elements'] != null) {
//       elements = [];
//       json['template_elements'].forEach((e) {
//         elements?.add(TemplateSingleItemModel.fromJson(e));
//       });
//     }
//   }
//   int? id;
//   num? userId;
//   String? title;
//   TextStyle? titleStyle;
//   String? name;
//   String? featureImg;
//   String? currency;
//   TextStyle? currencyStyle;
//   String? currencyAlignment;
//   String? description;
//   TextStyle? descriptionStyle;
//   String? backgroundColor;
//   String? backgroundImage;
//   String? orientation;
//   String? isLocked;
//   int? isPredefined;
//   String? createdAt;
//   String? updatedAt;
//   List<TemplateSingleItemModel>? elements;

// Template copyWith({  int? id,
//   num? userId,
//   String? title,
//   String? name,
//   String? featureImg,
//   String? currency,
//   String? currencyAlignment,
//   String? description,
//   String? backgroundColor,
//   String? backgroundImage,
//   String? orientation,
//   String? isLocked,
//   int? isPredefined,
//   String? createdAt,
//   String? updatedAt,
//   List<TemplateSingleItemModel>? elements,
// }) => Template(  id: id ?? id,
//   userId: userId ?? userId,
//   title: title ?? title,
//   name: name ?? name,
//   featureImg: featureImg ?? featureImg,
//   currency: currency ?? currency,
//   currencyAlignment: currencyAlignment ?? currencyAlignment,
//   description: description ?? description,
//   backgroundColor: backgroundColor ?? backgroundColor,
//   backgroundImage: backgroundImage ?? backgroundImage,
//   orientation: orientation ?? orientation,
//   isLocked: isLocked ?? isLocked,
//   isPredefined: isPredefined ?? isPredefined,
//   createdAt: createdAt ?? createdAt,
//   updatedAt: updatedAt ?? updatedAt,
//   elements: elements ?? elements,
// );

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['user_id'] = userId;
//     map['title'] = title;
//     map['name'] = name;
//     map['feature_img'] = featureImg;
//     map['currency'] = currency;
//     map['currency_alignment'] = currencyAlignment;
//     map['description'] = description;
//     map['background_color'] = backgroundColor;
//     map['background_image'] = backgroundImage;
//     map['orientation'] = orientation;
//     map['is_locked'] = isLocked;
//     map['is_predefined'] = isPredefined;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     if (elements != null) {
//       map['template_elements'] = elements?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

class TemplatesModel {
  final int id;
  final int userId;
  final String title;
  final String feature_img;
  final String currency;
  final String currency_alignment;
  final String description;
  final String background_color;
  final String background_image;
  final String orientation;
  final String isLocked;
  final String created_at;
  final String updated_at;
  final String name;
  final String status;
  final String is_live;
  final int is_predefined;
  final Map<String, dynamic> pivot;
  TemplatesModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.feature_img,
    required this.currency,
    required this.currency_alignment,
    required this.description,
    required this.background_color,
    required this.background_image,
    required this.orientation,
    required this.isLocked,
    required this.created_at,
    required this.updated_at,
    required this.name,
    required this.status,
    required this.is_live,
    required this.is_predefined,
    required this.pivot,
  });

  TemplatesModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? feature_img,
    String? currency,
    String? currency_alignment,
    String? description,
    String? background_color,
    String? background_image,
    String? orientation,
    String? isLocked,
    String? created_at,
    String? updated_at,
    String? name,
    String? status,
    String? is_live,
    int? is_predefined,
    Map<String, dynamic>? pivot,
  }) {
    return TemplatesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      feature_img: feature_img ?? this.feature_img,
      currency: currency ?? this.currency,
      currency_alignment: currency_alignment ?? this.currency_alignment,
      description: description ?? this.description,
      background_color: background_color ?? this.background_color,
      background_image: background_image ?? this.background_image,
      orientation: orientation ?? this.orientation,
      isLocked: isLocked ?? this.isLocked,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      name: name ?? this.name,
      status: status ?? this.status,
      is_live: is_live ?? this.is_live,
      is_predefined: is_predefined ?? this.is_predefined,
      pivot: pivot ?? this.pivot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'feature_img': feature_img,
      'currency': currency,
      'currency_alignment': currency_alignment,
      'description': description,
      'background_color': background_color,
      'background_image': background_image,
      'orientation': orientation,
      'isLocked': isLocked,
      'created_at': created_at,
      'updated_at': updated_at,
      'name': name,
      'status': status,
      'is_live': is_live,
      'is_predefined': is_predefined,
      'pivot': pivot,
    };
  }

  factory TemplatesModel.fromMap(Map<String, dynamic> map) {
    return TemplatesModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      feature_img: map['feature_img'] as String,
      currency: map['currency'] as String,
      currency_alignment: map['currency_alignment'] as String,
      description: map['description'] as String,
      background_color: map['background_color'] as String,
      background_image: map['background_image'] as String,
      orientation: map['orientation'] as String,
      isLocked: map['isLocked'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      is_live: map['is_live'] as String,
      is_predefined: map['is_predefined'] as int,
      pivot: Map<String, dynamic>.from(
        (map['pivot'] as Map<String, dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplatesModel.fromJson(String source) =>
      TemplatesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TemplatesModel(id: $id, userId: $userId, title: $title, feature_img: $feature_img, currency: $currency, currency_alignment: $currency_alignment, description: $description, background_color: $background_color, background_image: $background_image, orientation: $orientation, isLocked: $isLocked, created_at: $created_at, updated_at: $updated_at, name: $name, status: $status, is_live: $is_live, is_predefined: $is_predefined, pivot: $pivot)';
  }

  @override
  bool operator ==(covariant TemplatesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.feature_img == feature_img &&
        other.currency == currency &&
        other.currency_alignment == currency_alignment &&
        other.description == description &&
        other.background_color == background_color &&
        other.background_image == background_image &&
        other.orientation == orientation &&
        other.isLocked == isLocked &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.name == name &&
        other.status == status &&
        other.is_live == is_live &&
        other.is_predefined == is_predefined &&
        mapEquals(other.pivot, pivot);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        feature_img.hashCode ^
        currency.hashCode ^
        currency_alignment.hashCode ^
        description.hashCode ^
        background_color.hashCode ^
        background_image.hashCode ^
        orientation.hashCode ^
        isLocked.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        name.hashCode ^
        status.hashCode ^
        is_live.hashCode ^
        is_predefined.hashCode ^
        pivot.hashCode;
  }
}
