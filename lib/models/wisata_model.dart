// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Wisata> wisataFromJson(String str) => List<Wisata>.from(json.decode(str).map((x) => Wisata.fromJson(x)));

String wisataToJson(List<Wisata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wisata {
    Wisata({
        required this.id,
        required this.name,
        required this.location,
        required this.description,
        required this.image,
        required this.categoryId,
        required this.lat,
        required this.long,
        required this.createdAt,
        required this.updatedAt,
        required this.kategori,
    });

    int id;
    String name;
    String location;
    String description;
    String image;
    String categoryId;
    String lat;
    String long;
    DateTime createdAt;
    DateTime updatedAt;
    Kategori kategori;

    factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
        lat: json["lat"],
        long: json["long"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        kategori: Kategori.fromJson(json["kategori"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "description": description,
        "image": image,
        "category_id": categoryId,
        "lat": lat,
        "long": long,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "kategori": kategori.toJson(),
    };
}

class Kategori {
    Kategori({
        required this.id,
        required this.name,
        required this.trending,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    String trending;
    DateTime createdAt;
    DateTime updatedAt;

    factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        name: json["name"],
        trending: json["trending"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "trending": trending,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
