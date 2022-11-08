// ignore_for_file: camel_case_types

class responseData8 {
  responseData8({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<menu> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData8.fromJson(Map<String, dynamic> json) => responseData8(
        data: List<menu>.from(json["data"].map((x) => menu.fromJson(x))),
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

class menu {
  menu(
      {required this.id,
      required this.name,
      required this.description,
      required this.available});

  int id;
  String name;
  String description;
  bool available;

  factory menu.fromJson(Map<String, dynamic> json) => menu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "available": available,
      };
}
