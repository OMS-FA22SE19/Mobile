import 'package:flutter/material.dart';

// ignore_for_file: camel_case_types

class responseAuth {
  responseAuth({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  AuthToken data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseAuth.fromJson(Map<String, dynamic> json) => responseAuth(
        data: AuthToken.fromJson(json["data"]),
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

class AuthToken {
  AuthToken(
      {required this.email,
      required this.jwtToken,
      required this.expiredAt,
      required this.refreshToken});

  String email;
  String jwtToken;
  DateTime expiredAt;
  String refreshToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        email: json["email"],
        jwtToken: json["jwtToken"],
        expiredAt: DateTime.parse(json["expiredAt"]),
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "jwtToken": jwtToken,
        "expiredAt": expiredAt.toIso8601String(),
        "refreshToken": refreshToken,
      };
}
