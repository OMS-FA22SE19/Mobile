// ignore_for_file: camel_case_types

class responseData7 {
  responseData7({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<Reservation> data;
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
        data: List<Reservation>.from(
            json["data"].map((x) => Reservation.fromJson(x))),
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

// class reservation {
//   reservation({
//     required this.startTime,
//     required this.endTime,
//     required this.id,
//     required this.tableId,
//     required this.userId,
//     required this.status,
//     // required this.table,
//     // required this.user
//   });

//   int id;
//   String userId;
//   int tableId;
//   String startTime;
//   String endTime;
//   String status;
//   // String table;
//   // String user;

//   factory reservation.fromJson(Map<String, dynamic> json) => reservation(
//         id: json["id"],
//         userId: json["userId"],
//         tableId: json["tableId"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         status: json["status"],
//         // table: json["table"],
//         // user: json["user"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "tableId": tableId,
//         "startTime": startTime,
//         "endTime": endTime,
//         "status": status,
//         // "table": table,
//         // "user": user,
//       };
// }

class Reservation {
  Reservation({
    required this.id,
    required this.userId,
    required this.tableId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isPriorFoodOrder,
    required this.table,
    required this.user,
  });

  int id;
  String userId;
  int tableId;
  DateTime startTime;
  DateTime endTime;
  String status;
  bool isPriorFoodOrder;
  Table table;
  User user;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        userId: json["userId"],
        tableId: json["tableId"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        status: json["status"],
        isPriorFoodOrder: json["isPriorFoodOrder"],
        table: Table.fromJson(json["table"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "tableId": tableId,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "status": status,
        "isPriorFoodOrder": isPriorFoodOrder,
        "table": table.toJson(),
        "user": user.toJson(),
      };
}

class Table {
  Table({
    required this.id,
    required this.numOfSeats,
    required this.status,
    required this.tableType,
  });

  int id;
  int numOfSeats;
  String status;
  TableType tableType;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
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
  });

  int id;
  String name;
  int chargePerSeat;

  factory TableType.fromJson(Map<String, dynamic> json) => TableType(
        id: json["id"],
        name: json["name"],
        chargePerSeat: json["chargePerSeat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chargePerSeat": chargePerSeat,
      };
}

class User {
  User({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.phoneNumber,
    required this.isDeleted,
  });

  String id;
  String userName;
  String fullName;
  String phoneNumber;
  bool isDeleted;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "isDeleted": isDeleted,
      };
}
