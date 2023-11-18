import 'dart:convert';

String courseCenterModelToJson(List<CourseCenterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseCenterModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  CourseCenterModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory CourseCenterModel.fromJson(Map<String, dynamic> json) =>
      CourseCenterModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        price: json["price"] ?? 0.0,
        description: json["description"] ?? "",
        category: json["category"] ?? "",
        image: json["image"] ?? "",
        rating: json["rating"] == null
            ? Rating.fromJson({})
            : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}


class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"] ?? 0.0,
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

