// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';
// ignore_for_file: camel_case_types

class responseSettings {
  responseSettings({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<adminSettings> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseSettings.fromJson(Map<String, dynamic> json) =>
      responseSettings(
        data: List<adminSettings>.from(
            json["data"].map((x) => adminSettings.fromJson(x))),
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

class adminSettings {
  adminSettings({
    required this.name,
    required this.value,
  });

  String name;
  String value;

  factory adminSettings.fromJson(Map<String, dynamic> json) => adminSettings(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
