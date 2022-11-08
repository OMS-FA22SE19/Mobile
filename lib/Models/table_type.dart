// ignore_for_file: camel_case_types

class responseData4 {
  responseData4({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<tableType> data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseData4.fromJson(Map<String, dynamic> json) => responseData4(
        data: List<tableType>.from(
            json["data"].map((x) => tableType.fromJson(x))),
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

class responseTableType {
  responseTableType({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  tableType data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseTableType.fromJson(Map<String, dynamic> json) =>
      responseTableType(
        data: tableType.fromJson(json["data"]),
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

class tableType {
  tableType(
      {required this.id, required this.name, required this.chargePerSeat});

  int id;
  String name;
  int chargePerSeat;

  factory tableType.fromJson(Map<String, dynamic> json) => tableType(
      id: json["id"], name: json["name"], chargePerSeat: json["chargePerSeat"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "chargePerSeat": chargePerSeat};
}
