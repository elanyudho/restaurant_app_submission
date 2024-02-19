class RestaurantSearchResult {
  RestaurantSearchResult({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool? error;
  int? founded;
  List<Restaurant?>? restaurants;

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) => RestaurantSearchResult(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from((json["restaurants"] as List)
        .map((x) => Restaurant.fromJson(x))
        .where((restaurant) =>
    restaurant.id != null &&
        restaurant.name != null &&
        restaurant.pictureId != null &&
        restaurant.description != null &&
        restaurant.rating != null &&
        restaurant.city != null )),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x!.toJson())),
  };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}