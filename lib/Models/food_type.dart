// ignore_for_file: camel_case_types

class responseData2 {
  responseData2({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<foodType> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData2.fromJson(Map<String, dynamic> json) => responseData2(
        data:
            List<foodType>.from(json["data"].map((x) => foodType.fromJson(x))),
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

class foodType {
  foodType({required this.id, required this.name});

  int id;
  String name;

  factory foodType.fromJson(Map<String, dynamic> json) =>
      foodType(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
