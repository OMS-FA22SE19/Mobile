// ignore_for_file: camel_case_types

class responseData7 {
  responseData7({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<reservation> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData7.fromJson(Map<String, dynamic> json) => responseData7(
        data: List<reservation>.from(
            json["data"].map((x) => reservation.fromJson(x))),
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

class reservation {
  reservation({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.tableId,
    required this.userId,
    required this.status,
    // required this.table,
    // required this.user
  });

  int id;
  String userId;
  int tableId;
  String startTime;
  String endTime;
  String status;
  // String table;
  // String user;

  factory reservation.fromJson(Map<String, dynamic> json) => reservation(
        id: json["id"],
        userId: json["userId"],
        tableId: json["tableId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        status: json["status"],
        // table: json["table"],
        // user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "tableId": tableId,
        "startTime": startTime,
        "endTime": endTime,
        "status": status,
        // "table": table,
        // "user": user,
      };
}
