// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<Datum> data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "succeeded": succeeded,
        "statusCode": statusCode,
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.isDeleted,
  });

  int id;
  String name;
  bool isDeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isDeleted": isDeleted,
      };
}
