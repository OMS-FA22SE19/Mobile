// ignore_for_file: camel_case_types

class responseData {
  responseData({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<courseType> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData.fromJson(Map<String, dynamic> json) => responseData(
        data: List<courseType>.from(
            json["data"].map((x) => courseType.fromJson(x))),
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

class courseType {
  courseType({required this.id, required this.name});

  int id;
  String name;

  factory courseType.fromJson(Map<String, dynamic> json) =>
      courseType(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
