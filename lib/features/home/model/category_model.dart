class CategoryModel {
  CategoryModel({num? id, String? name, String? imageFullUrl}) {
    _id = id;
    _name = name;
    _imageFullUrl = imageFullUrl;
  }

  CategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageFullUrl = json['image_full_url'];
  }

  num? _id;
  String? _name;
  String? _imageFullUrl;

  CategoryModel copyWith({num? id, String? name, String? imageFullUrl}) =>
      CategoryModel(id: id ?? _id, name: name ?? _name, imageFullUrl: imageFullUrl ?? _imageFullUrl);

  num? get id => _id;

  String? get name => _name;

  String? get imageFullUrl => _imageFullUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image_full_url'] = _imageFullUrl;
    return map;
  }
}
