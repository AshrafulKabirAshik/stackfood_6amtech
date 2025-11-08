class PopularFoodModel {
  PopularFoodModel({num? id, String? name, num? price, num? avgRating, num? ratingCount, String? restaurantName, String? imageFullUrl}) {
    _id = id;
    _name = name;
    _price = price;
    _avgRating = avgRating;
    _ratingCount = ratingCount;
    _restaurantName = restaurantName;
    _imageFullUrl = imageFullUrl;
  }

  PopularFoodModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _avgRating = json['avg_rating'];
    _ratingCount = json['rating_count'];
    _restaurantName = json['restaurant_name'];
    _imageFullUrl = json['image_full_url'];
  }

  num? _id;
  String? _name;
  num? _price;
  num? _avgRating;
  num? _ratingCount;
  String? _restaurantName;
  String? _imageFullUrl;

  PopularFoodModel copyWith({num? id, String? name, num? price, num? avgRating, num? ratingCount, String? restaurantName, String? imageFullUrl}) =>
      PopularFoodModel(
        id: id ?? _id,
        name: name ?? _name,
        price: price ?? _price,
        avgRating: avgRating ?? _avgRating,
        ratingCount: ratingCount ?? _ratingCount,
        restaurantName: restaurantName ?? _restaurantName,
        imageFullUrl: imageFullUrl ?? _imageFullUrl,
      );

  num? get id => _id;

  String? get name => _name;

  num? get price => _price;

  num? get avgRating => _avgRating;

  num? get ratingCount => _ratingCount;

  String? get restaurantName => _restaurantName;

  String? get imageFullUrl => _imageFullUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['avg_rating'] = _avgRating;
    map['rating_count'] = _ratingCount;
    map['restaurant_name'] = _restaurantName;
    map['image_full_url'] = _imageFullUrl;
    return map;
  }
}
