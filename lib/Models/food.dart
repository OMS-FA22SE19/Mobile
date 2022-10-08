// ignore_for_file: camel_case_types
class responseData12 {
  responseData12({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  foodWithoutPrice data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData12.fromJson(Map<String, dynamic> json) => responseData12(
        data: foodWithoutPrice.fromJson(json["data"]),
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
  food({
    required this.id,
    required this.name,
    required this.available,
    required this.description,
    required this.ingredient,
    required this.pictureUrl,
    required this.isDeleted,
    required this.price,
    required this.quantity,
  });

  int quantity;
  int id;
  String name;
  String description;
  String ingredient;
  bool isDeleted;
  bool available;
  String pictureUrl;
  int price;

  factory food.fromJson(Map<String, dynamic> json) => food(
        quantity: 0,
        id: json["id"],
        name: json["name"],
        available: json["available"],
        description: json["description"],
        ingredient: json["ingredient"],
        isDeleted: json["isDeleted"],
        pictureUrl: json["pictureUrl"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "available": available,
        "description": description,
        "ingredient": ingredient,
        "pictureUrl": pictureUrl,
        "isDeleted": isDeleted,
        "price": price,
      };
}

class foodWithoutPrice {
  foodWithoutPrice({
    required this.id,
    required this.name,
    required this.available,
    required this.description,
    required this.ingredient,
    required this.pictureUrl,
    required this.isDeleted,
    required this.quantity,
  });

  int quantity;
  int id;
  String name;
  String description;
  String ingredient;
  bool isDeleted;
  bool available;
  String pictureUrl;

  factory foodWithoutPrice.fromJson(Map<String, dynamic> json) =>
      foodWithoutPrice(
          quantity: 0,
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
        "isDeleted": isDeleted
      };
}
