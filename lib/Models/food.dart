// ignore_for_file: camel_case_types

import 'package:oms_mobile/Models/course_type.dart';

class responseData3 {
  responseData3({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<food> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData3.fromJson(Map<String, dynamic> json) => responseData3(
        data: List<food>.from(json["data"].map((x) => food.fromJson(x))),
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "succeeded": succeeded,
        "statusCode": statusCode,
        "message": message,
      };
}

class food {
  food(
      {required this.id,
      required this.name,
      required this.available,
      required this.description,
      required this.ingredient,
      required this.pictureUrl,
      required this.isDeleted});

  int id;
  String name;
  String description;
  String ingredient;
  bool isDeleted;
  bool available;
  String pictureUrl;

  factory food.fromJson(Map<String, dynamic> json) => food(
      id: json["id"],
      name: json["name"],
      available: json["available"],
      description: json["description"],
      ingredient: json["ingredient"],
      isDeleted: json["isDeleted"],
      pictureUrl: json["pictureUrl"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
        "description": description,
        "ingredient": ingredient,
        "pictureUrl": pictureUrl,
        "isDeleted": isDeleted,
      };
}
