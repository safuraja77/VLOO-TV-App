// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  final bool is_template;
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
    required this.is_template,
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
    bool? is_template,
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
      is_template: is_template ?? this.is_template,
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
      'is_template': is_template,
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
      pivot: Map<String, dynamic>.from((map['pivot'] as Map<String, dynamic>),),
      is_template: map['is_template'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplatesModel.fromJson(String source) =>
      TemplatesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TemplatesModel(id: $id, userId: $userId, title: $title, feature_img: $feature_img, currency: $currency, currency_alignment: $currency_alignment, description: $description, background_color: $background_color, background_image: $background_image, orientation: $orientation, isLocked: $isLocked, created_at: $created_at, updated_at: $updated_at, name: $name, status: $status, is_live: $is_live, is_predefined: $is_predefined, pivot: $pivot, is_template: $is_template)';
  }

  @override
  bool operator ==(covariant TemplatesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
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
      mapEquals(other.pivot, pivot) &&
      other.is_template == is_template;
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
      pivot.hashCode ^
      is_template.hashCode;
  }
}
