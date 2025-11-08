class BannerModel {
  BannerModel({num? id, String? title, String? imageFullUrl}) {
    _id = id;
    _title = title;
    _imageFullUrl = imageFullUrl;
  }

  BannerModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _imageFullUrl = json['image_full_url'];
  }

  num? _id;
  String? _title;
  String? _imageFullUrl;

  BannerModel copyWith({num? id, String? title, String? imageFullUrl}) =>
      BannerModel(id: id ?? _id, title: title ?? _title, imageFullUrl: imageFullUrl ?? _imageFullUrl);

  num? get id => _id;

  String? get title => _title;

  String? get imageFullUrl => _imageFullUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_full_url'] = _imageFullUrl;
    return map;
  }
}
