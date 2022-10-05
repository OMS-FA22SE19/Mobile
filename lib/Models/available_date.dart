// ignore_for_file: camel_case_types

class responseData6 {
  responseData6({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<availableDate> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData6.fromJson(Map<String, dynamic> json) => responseData6(
        data: List<availableDate>.from(
            json["data"].map((x) => availableDate.fromJson(x))),
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

class availableDate {
  availableDate({required this.startTime, required this.endTime});

  String startTime;
  String endTime;

  factory availableDate.fromJson(Map<String, dynamic> json) => availableDate(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}
