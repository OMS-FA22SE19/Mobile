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

// class table {
//   table(
//       {required this.numOfSeats,
//       required this.tableTypeId,
//       required this.tableTypeName,
//       required this.total});

//   int numOfSeats;
//   int tableTypeId;
//   String tableTypeName;
//   int total;

//   factory table.fromJson(Map<String, dynamic> json) => table(
//         numOfSeats: json["numOfSeats"],
//         tableTypeId: json["tableTypeId"],
//         tableTypeName: json["tableTypeName"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "tableTypeId": tableTypeId,
//         "numOfSeats": numOfSeats,
//         "tableTypeName": tableTypeName,
//         "total": total,
//       };
// }

class table {
  table({
    required this.id,
    required this.numOfSeats,
    required this.status,
    required this.tableType,
  });

  int id;
  int numOfSeats;
  String status;
  TableType tableType;

  factory table.fromJson(Map<String, dynamic> json) => table(
        id: json["id"],
        numOfSeats: json["numOfSeats"],
        status: json["status"],
        tableType: TableType.fromJson(json["tableType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numOfSeats": numOfSeats,
        "status": status,
        "tableType": tableType.toJson(),
      };
}

class TableType {
  TableType({
    required this.id,
    required this.name,
    required this.chargePerSeat,
    required this.canBeCombined,
  });

  int id;
  String name;
  int chargePerSeat;
  bool canBeCombined;

  factory TableType.fromJson(Map<String, dynamic> json) => TableType(
        id: json["id"],
        name: json["name"],
        chargePerSeat: json["chargePerSeat"],
        canBeCombined: json["canBeCombined"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chargePerSeat": chargePerSeat,
        "canBeCombined": canBeCombined,
      };
}

class responseData25 {
  responseData25({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<tableAvailable> data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseData25.fromJson(Map<String, dynamic> json) => responseData25(
        data: List<tableAvailable>.from(
            json["data"].map((x) => tableAvailable.fromJson(x))),
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "succeeded": succeeded,
        "statusCode": statusCode,
        "message": message,
      };
}

class tableAvailable {
  tableAvailable({
    required this.numOfSeats,
    required this.tableTypeId,
    required this.tableTypeName,
    required this.quantity,
  });

  int numOfSeats;
  int tableTypeId;
  String tableTypeName;
  int quantity;

  factory tableAvailable.fromJson(Map<String, dynamic> json) => tableAvailable(
        numOfSeats: json["numOfSeats"],
        tableTypeId: json["tableTypeId"],
        tableTypeName: json["tableTypeName"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "numOfSeats": numOfSeats,
        "tableTypeId": tableTypeId,
        "tableTypeName": tableTypeName,
        "quantity": quantity,
      };
}
