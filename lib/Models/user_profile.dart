// ignore_for_file: camel_case_types

class responseUser {
  responseUser({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  UserProfile data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseUser.fromJson(Map<String, dynamic> json) => responseUser(
        data: UserProfile.fromJson(json["data"]),
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

class UserProfile {
  UserProfile({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.isDeleted,
  });

  String id;
  String userName;
  String fullName;
  String email;
  String phoneNumber;
  bool isDeleted;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      id: json["id"],
      userName: json["userName"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      isDeleted: json["isDeleted"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "isDeleted": isDeleted,
      };
}
