// // ignore_for_file: camel_case_types

// class responseData7 {
//   responseData7({
//     required this.data,
//     required this.succeeded,
//     required this.statusCode,
//     required this.message,
//   });

//   List<Reservation> data;
//   bool succeeded;
//   String statusCode;
//   dynamic message;
//   // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
//   //       data: json["data"],
//   //       succeeded: json["succeeded"],
//   //       statusCode: json["statusCode"],
//   //       message: json["message"],
//   //     );

//   factory responseData7.fromJson(Map<String, dynamic> json) => responseData7(
//         data: List<Reservation>.from(
//             json["data"].map((x) => Reservation.fromJson(x))),
//         succeeded: json["succeeded"],
//         statusCode: json["statusCode"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data,
//         "succeeded": succeeded,
//         "statusCode": statusCode,
//         "message": message,
//       };
// }

// // class reservation {
// //   reservation({
// //     required this.startTime,
// //     required this.endTime,
// //     required this.id,
// //     required this.tableId,
// //     required this.userId,
// //     required this.status,
// //     // required this.table,
// //     // required this.user
// //   });

// //   int id;
// //   String userId;
// //   int tableId;
// //   String startTime;
// //   String endTime;
// //   String status;
// //   // String table;
// //   // String user;

// //   factory reservation.fromJson(Map<String, dynamic> json) => reservation(
// //         id: json["id"],
// //         userId: json["userId"],
// //         tableId: json["tableId"],
// //         startTime: json["startTime"],
// //         endTime: json["endTime"],
// //         status: json["status"],
// //         // table: json["table"],
// //         // user: json["user"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "userId": userId,
// //         "tableId": tableId,
// //         "startTime": startTime,
// //         "endTime": endTime,
// //         "status": status,
// //         // "table": table,
// //         // "user": user,
// //       };
// // }

// class Reservation {
//   Reservation({
//     required this.id,
//     required this.userId,
//     required this.tableId,
//     required this.startTime,
//     required this.endTime,
//     required this.status,
//     required this.isPriorFoodOrder,
//     required this.reservationTables,
//     required this.user,
//   });

//   int id;
//   String userId;
//   int tableId;
//   DateTime startTime;
//   DateTime endTime;
//   String status;
//   bool isPriorFoodOrder;
//   reservationTable reservationTables;
//   User user;

//   factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
//         id: json["id"],
//         userId: json["userId"],
//         tableId: json["tableId"],
//         startTime: DateTime.parse(json["startTime"]),
//         endTime: DateTime.parse(json["endTime"]),
//         status: json["status"],
//         isPriorFoodOrder: json["isPriorFoodOrder"],
//         reservationTables: reservationTable.fromJson(json["reservationTables"]),
//         user: User.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "tableId": tableId,
//         "startTime": startTime.toIso8601String(),
//         "endTime": endTime.toIso8601String(),
//         "status": status,
//         "isPriorFoodOrder": isPriorFoodOrder,
//         "table": reservationTables.toJson(),
//         "user": user.toJson(),
//       };
// }

// class reservationTable {
//   reservationTable({
//     required this.id,
//     required this.numOfSeats,
//     required this.status,
//     required this.tableType,
//   });

//   int id;
//   int numOfSeats;
//   String status;
//   TableType tableType;

//   factory reservationTable.fromJson(Map<String, dynamic> json) =>
//       reservationTable(
//         id: json["id"],
//         numOfSeats: json["numOfSeats"],
//         status: json["status"],
//         tableType: TableType.fromJson(json["tableType"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "numOfSeats": numOfSeats,
//         "status": status,
//         "tableType": tableType.toJson(),
//       };
// }

// class TableType {
//   TableType({
//     required this.id,
//     required this.name,
//     required this.chargePerSeat,
//   });

//   int id;
//   String name;
//   int chargePerSeat;

//   factory TableType.fromJson(Map<String, dynamic> json) => TableType(
//         id: json["id"],
//         name: json["name"],
//         chargePerSeat: json["chargePerSeat"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "chargePerSeat": chargePerSeat,
//       };
// }

// ignore_for_file: camel_case_types

class ReservationTable {
  ReservationTable({
    required this.tableId,
    required this.table,
  });

  int tableId;
  TableModel table;

  factory ReservationTable.fromJson(Map<String, dynamic> json) =>
      ReservationTable(
        tableId: json["tableId"],
        table: TableModel.fromJson(json["table"]),
      );

  Map<String, dynamic> toJson() => {
        "tableId": tableId,
        "table": table.toJson(),
      };
}

class TableModel {
  TableModel({
    required this.id,
    required this.numOfSeats,
    required this.status,
    required this.isDeleted,
    required this.tableType,
  });

  int id;
  int numOfSeats;
  String status;
  bool isDeleted;
  TableType tableType;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        numOfSeats: json["numOfSeats"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        tableType: TableType.fromJson(json["tableType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numOfSeats": numOfSeats,
        "status": status,
        "isDeleted": isDeleted,
        "tableType": tableType.toJson(),
      };
}

class TableType {
  TableType({
    required this.id,
    required this.name,
    required this.chargePerSeat,
    required this.canBeCombined,
    required this.isDeleted,
  });

  int id;
  String name;
  int chargePerSeat;
  bool canBeCombined;
  bool isDeleted;

  factory TableType.fromJson(Map<String, dynamic> json) => TableType(
        id: json["id"],
        name: json["name"],
        chargePerSeat: json["chargePerSeat"],
        canBeCombined: json["canBeCombined"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chargePerSeat": chargePerSeat,
        "canBeCombined": canBeCombined,
        "isDeleted": isDeleted,
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

class orderDetailss {
  orderDetailss({
    required this.orderId,
    // this.userId,
    required this.date,
    required this.foodId,
    required this.foodName,
    required this.status,
    required this.price,
    // this.note,
    required this.quantity,
    required this.amount,
  });

  String orderId;
  // String userId;
  DateTime date;
  int foodId;
  String foodName;
  String status;
  int price;
  // String note;
  int quantity;
  int amount;

  factory orderDetailss.fromJson(Map<String, dynamic> json) => orderDetailss(
        orderId: json["orderId"],
        // userId: json["userId"],
        date: DateTime.parse(json["date"]),
        foodId: json["foodId"],
        foodName: json["foodName"],
        status: json["status"],
        price: json["price"],
        // note: json["note"],
        quantity: json["quantity"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        // "userId": userId,
        "date": date.toIso8601String(),
        "foodId": foodId,
        "foodName": foodName,
        "status": status,
        "price": price,
        // "note": note,
        "quantity": quantity,
        "amount": amount,
      };
}

class ReservationNoTable {
  ReservationNoTable({
    required this.id,
    // required this.userId,
    required this.numOfPeople,
    required this.tableTypeId,
    required this.tableType,
    required this.numOfSeats,
    required this.quantity,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isPriorFoodOrder,
    required this.user,
    required this.prePaid,
    required this.paid,
    required this.fullName,
    required this.phoneNumber,
    required this.created,
    this.reasonForCancel = "empty",
    required this.numOfEdits,
    this.reservationTables = const [],
    this.orderDetails = const [],
  });

  int id;
  // String userId;
  int numOfPeople;
  int tableTypeId;
  String tableType;
  int numOfSeats;
  int quantity;
  DateTime startTime;
  DateTime endTime;
  String status;
  bool isPriorFoodOrder;
  User user;
  int prePaid;
  int paid;
  String fullName;
  String phoneNumber;
  DateTime created;
  String reasonForCancel;
  int numOfEdits;
  List<ReservationTable> reservationTables;
  List<orderDetailss> orderDetails;

  factory ReservationNoTable.fromJson(Map<String, dynamic> json) =>
      ReservationNoTable(
        id: json["id"],
        // userId: json["userId"],
        numOfPeople: json["numOfPeople"],
        tableTypeId: json["tableTypeId"],
        tableType: json["tableType"],
        numOfSeats: json["numOfSeats"],
        quantity: json["quantity"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        status: json["status"],
        prePaid: json["prePaid"],
        paid: json["paid"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        numOfEdits: json["numOfEdits"],
        created: DateTime.parse(json["created"]),
        isPriorFoodOrder: json["isPriorFoodOrder"],
        user: User.fromJson(json["user"]),
        reservationTables: List<ReservationTable>.from(
            json["reservationTables"].map((x) => ReservationTable.fromJson(x))),
        orderDetails: List<orderDetailss>.from(
            json["orderDetails"].map((x) => orderDetailss.fromJson(x))),
      );

  factory ReservationNoTable.fromJsonFor(Map<String, dynamic> json) =>
      ReservationNoTable(
        id: json["id"],
        // userId: json["userId"],
        numOfPeople: json["numOfPeople"],
        tableTypeId: json["tableTypeId"],
        tableType: json["tableType"],
        numOfSeats: json["numOfSeats"],
        quantity: json["quantity"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        status: json["status"],
        prePaid: json["prePaid"],
        paid: json["paid"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        numOfEdits: json["numOfEdits"],
        created: DateTime.parse(json["created"]),
        reasonForCancel: json["reasonForCancel"],
        isPriorFoodOrder: json["isPriorFoodOrder"],
        user: User.fromJson(json["user"]),
        reservationTables: List<ReservationTable>.from(
            json["reservationTables"].map((x) => ReservationTable.fromJson(x))),
        orderDetails: List<orderDetailss>.from(
            json["orderDetails"].map((x) => orderDetailss.fromJson(x))),
      );

  factory ReservationNoTable.fromJsonResponse(Map<String, dynamic> json) =>
      ReservationNoTable(
        id: json["id"],
        // userId: json["userId"],
        numOfPeople: json["numOfPeople"],
        tableTypeId: json["tableTypeId"],
        tableType: json["tableType"],
        numOfSeats: json["numOfSeats"],
        quantity: json["quantity"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        status: json["status"],
        prePaid: json["prePaid"],
        paid: json["paid"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        numOfEdits: json["numOfEdits"],
        created: DateTime.parse(json["created"]),
        isPriorFoodOrder: json["isPriorFoodOrder"],
        user: User.fromJson(json["user"]),
        reservationTables: List<ReservationTable>.from(
            json["reservationTables"].map((x) => ReservationTable.fromJson(x))),
      );

  factory ReservationNoTable.fromJsonResponseFor(Map<String, dynamic> json) =>
      ReservationNoTable(
        id: json["id"],
        // userId: json["userId"],
        numOfPeople: json["numOfPeople"],
        tableTypeId: json["tableTypeId"],
        tableType: json["tableType"],
        numOfSeats: json["numOfSeats"],
        quantity: json["quantity"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        status: json["status"],
        prePaid: json["prePaid"],
        paid: json["paid"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        numOfEdits: json["numOfEdits"],
        created: DateTime.parse(json["created"]),
        isPriorFoodOrder: json["isPriorFoodOrder"],
        user: User.fromJson(json["user"]),
        reservationTables: List<ReservationTable>.from(
            json["reservationTables"].map((x) => ReservationTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "userId": userId,
        "numOfPeople": numOfPeople,
        "tableTypeId": tableTypeId,
        "tableType": tableType,
        "numOfSeats": numOfSeats,
        "quantity": quantity,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "status": status,
        "prePaid": prePaid,
        "paid": paid,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "created": created.toIso8601String(),
        "isPriorFoodOrder": isPriorFoodOrder,
        "user": user.toJson(),
        "reservationTables":
            List<dynamic>.from(reservationTables.map((x) => x.toJson())),
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class responseReservation {
  responseReservation({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<ReservationNoTable> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseReservation.fromJson(Map<String, dynamic> json) =>
      responseReservation(
        data: List<ReservationNoTable>.from(
            json["data"].map((x) => ReservationNoTable.fromJson(x))),
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  factory responseReservation.fromJsonFor(Map<String, dynamic> json) =>
      responseReservation(
        data: List<ReservationNoTable>.from(
            json["data"].map((x) => ReservationNoTable.fromJsonFor(x))),
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

class responseOneReservation {
  responseOneReservation({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  ReservationNoTable data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseOneReservation.fromJson(Map<String, dynamic> json) =>
      responseOneReservation(
        data: ReservationNoTable.fromJson(json["data"]),
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  factory responseOneReservation.fromJsonFor(Map<String, dynamic> json) =>
      responseOneReservation(
        data: ReservationNoTable.fromJsonFor(json["data"]),
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

class responseReservationPreorder {
  responseReservationPreorder({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  ReservationNoTable data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseReservationPreorder.fromJson(Map<String, dynamic> json) =>
      responseReservationPreorder(
        data: ReservationNoTable.fromJsonResponse(json["data"]),
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

class responseReservationPreorderFor {
  responseReservationPreorderFor({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  ReservationNoTable data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseReservationPreorderFor.fromJson(Map<String, dynamic> json) =>
      responseReservationPreorderFor(
        data: ReservationNoTable.fromJsonResponse(json["data"]),
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
