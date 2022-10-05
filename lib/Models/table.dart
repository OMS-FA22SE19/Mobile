// ignore_for_file: camel_case_types

class responseData5 {
  responseData5({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<table> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData5.fromJson(Map<String, dynamic> json) => responseData5(
        data: List<table>.from(json["data"].map((x) => table.fromJson(x))),
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

class table {
  table(
      {required this.numOfSeats,
      required this.tableTypeId,
      required this.tableTypeName,
      required this.total});

  int numOfSeats;
  int tableTypeId;
  String tableTypeName;
  int total;

  factory table.fromJson(Map<String, dynamic> json) => table(
        numOfSeats: json["numOfSeats"],
        tableTypeId: json["tableTypeId"],
        tableTypeName: json["tableTypeName"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "tableTypeId": tableTypeId,
        "numOfSeats": numOfSeats,
        "tableTypeName": tableTypeName,
        "total": total,
      };
}
