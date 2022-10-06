// ignore_for_file: camel_case_types

class responseData10 {
  responseData10({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  List<orderDetail> data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData10.fromJson(Map<String, dynamic> json) => responseData10(
        data: List<orderDetail>.from(
            json["data"].map((x) => orderDetail.fromJson(x))),
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

class orderDetail {
  orderDetail({
    required this.date,
    required this.foodId,
    required this.foodName,
    required this.id,
    required this.orderId,
    required this.price,
    required this.status,
    required this.userId,
  });

  String orderId;
  int id;
  String userId;
  String date;
  int foodId;
  String foodName;
  int price;
  String status;

  factory orderDetail.fromJson(Map<String, dynamic> json) => orderDetail(
        id: json["id"],
        orderId: json["orderId"],
        userId: json["userId"],
        date: json["date"],
        foodId: json["foodId"],
        foodName: json["foodName"],
        status: json["status"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "userId": userId,
        "date": date,
        "foodId": foodId,
        "foodName": foodName,
        "status": status,
        "price": price,
      };
}
