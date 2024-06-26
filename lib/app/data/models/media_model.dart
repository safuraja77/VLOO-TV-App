class MediaModel {
  MediaModel({
    this.id,
    this.userId,
    this.name,
    this.url,
    this.type,
    this.format,
    this.resolution,
    this.duration,
    this.filesize,
    this.createdAt,
    this.updatedAt,
    this.localUrl,
    this.thumbnail,
    this.is_template,
  });

  MediaModel.fromMap(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    url = json['url'];
    type = json['type'];
    format = json['format'];
    resolution = json['resolution'];
    duration = json['duration'];
    filesize = json['filesize'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    thumbnail = json['thumbnail'];
    localUrl = json['localUrl'];
    is_template = json['is_template'];
  }
  num? id;
  num? userId;
  String? name;
  String? url;
  String? type;
  String? format;
  String? resolution;
  String? duration;
  String? filesize;
  String? createdAt;
  String? updatedAt;
  String? thumbnail;
  String? localUrl;
  bool? is_template;

  MediaModel copyWith({
    num? id,
    num? userId,
    String? name,
    String? url,
    String? type,
    String? format,
    String? resolution,
    String? duration,
    String? filesize,
    String? createdAt,
    String? updatedAt,
    String? thumbnail,
    String? localUrl,
    bool? is_template,
  }) =>
      MediaModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        url: url ?? this.url,
        type: type ?? this.type,
        format: format ?? this.format,
        resolution: resolution ?? this.resolution,
        duration: duration ?? this.duration,
        filesize: filesize ?? this.filesize,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        thumbnail: thumbnail ?? this.thumbnail,
        localUrl: localUrl ?? this.localUrl,
        is_template: is_template ?? is_template,
      );
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['url'] = url;
    map['type'] = type;
    map['format'] = format;
    map['resolution'] = resolution;
    map['duration'] = duration;
    map['filesize'] = filesize;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['thumbnail'] = thumbnail;
    map['localUrl'] = localUrl;
    map['is_template'] = is_template;
    return map;
  }
}
