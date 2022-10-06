// ignore_for_file: camel_case_types

class responseData9 {
  responseData9({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  order data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData9.fromJson(Map<String, dynamic> json) => responseData9(
        data: order.fromJson(json["data"]),
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

class order {
  order({
    required this.id,
    required this.userId,
    required this.date,
    // required this.fullName,
    required this.phoneNumber,
    required this.prePaid,
    required this.status,
    required this.total,
  });

  String id;
  String userId;
  // String fullName;
  String phoneNumber;
  String date;
  String status;
  int prePaid;
  int total;

  // factory order.fromJson(Map<String, dynamic> json) => order(
  //       id: json["id"],
  //       userId: json["userId"],
  //       fullName: json["fullName"],
  //       phoneNumber: json["phoneNumber"],
  //       date: json["date"],
  //       status: json["status"],
  //       prePaid: json["prePaid"],
  //       total: json["total"],
  //     );

  factory order.fromJson(Map<String, dynamic> json) => order(
        id: json["id"],
        userId: json["userId"],
        // fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        date: json["date"],
        status: json["status"],
        prePaid: json["prePaid"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        // "fullName": fullName,
        "phoneNumber": phoneNumber,
        "date": date,
        "status": status,
        "prePaid": prePaid,
        "total": total,
      };
}
