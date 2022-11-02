// ignore_for_file: camel_case_types

// class responseData9 {
//   responseData9({
//     required this.data,
//     required this.succeeded,
//     required this.statusCode,
//     required this.message,
//   });

//   order data;
//   bool succeeded;
//   String statusCode;
//   dynamic message;
//   // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
//   //       data: json["data"],
//   //       succeeded: json["succeeded"],
//   //       statusCode: json["statusCode"],
//   //       message: json["message"],
//   //     );

//   factory responseData9.fromJson(Map<String, dynamic> json) => responseData9(
//         data: order.fromJson(json["data"]),
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

// class order {
//   order({
//     required this.id,
//     required this.userId,
//     required this.date,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.prePaid,
//     required this.status,
//     required this.total,
//   });

//   String id;
//   String userId;
//   String fullName;
//   String phoneNumber;
//   String date;
//   String status;
//   int prePaid;
//   int total;

//   // factory order.fromJson(Map<String, dynamic> json) => order(
//   //       id: json["id"],
//   //       userId: json["userId"],
//   //       fullName: json["fullName"],
//   //       phoneNumber: json["phoneNumber"],
//   //       date: json["date"],
//   //       status: json["status"],
//   //       prePaid: json["prePaid"],
//   //       total: json["total"],
//   //     );

//   factory order.fromJson(Map<String, dynamic> json) => order(
//         id: json["id"],
//         userId: json["userId"],
//         fullName: json["fullName"],
//         phoneNumber: json["phoneNumber"],
//         date: json["date"],
//         status: json["status"],
//         prePaid: json["prePaid"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "fullName": fullName,
//         "phoneNumber": phoneNumber,
//         "date": date,
//         "status": status,
//         "prePaid": prePaid,
//         "total": total,
//       };
// }

class ResponseOrder {
  ResponseOrder({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<Order> data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory ResponseOrder.fromJson(Map<String, dynamic> json) => ResponseOrder(
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
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

class responseData15 {
  responseData15({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  Order data;
  bool succeeded;
  String statusCode;
  dynamic message;

  factory responseData15.fromJson(Map<String, dynamic> json) => responseData15(
        data: Order.fromJson(json["data"]),
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

class Order {
  Order({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.date,
    required this.status,
    required this.prePaid,
    required this.total,
    required this.orderDetails,
  });

  String id;
  String userId;
  dynamic fullName;
  String phoneNumber;
  String date;
  String status;
  int prePaid;
  int total;
  List<OrderDetail> orderDetails;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["userId"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        date: json["date"],
        status: json["status"],
        prePaid: json["prePaid"],
        total: json["total"],
        orderDetails: List<OrderDetail>.from(
            json["orderDetails"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "date": date,
        "status": status,
        "prePaid": prePaid,
        "total": total,
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    required this.orderId,
    this.userId = "",
    this.date = "",
    required this.foodId,
    required this.foodName,
    required this.status,
    required this.price,
    required this.quantity,
    required this.amount,
  });

  String orderId;
  String userId;
  String date;
  int foodId;
  String foodName;
  String status;
  int price;
  int quantity;
  int amount;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json["orderId"],
        // userId: json["userId"],
        // date: json["date"],
        foodId: json["foodId"],
        foodName: json["foodName"],
        status: json["status"],
        price: json["price"],
        quantity: json["quantity"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        // "userId": userId,
        // "date": date,
        "foodId": foodId,
        "foodName": foodName,
        "status": status,
        "price": price,
        "quantity": quantity,
        "amount": amount,
      };
}
