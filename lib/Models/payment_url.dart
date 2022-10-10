// ignore_for_file: camel_case_types

class responseData20 {
  responseData20({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.message,
  });

  paymentURL data;
  bool succeeded;
  String statusCode;
  dynamic message;
  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory responseData20.fromJson(Map<String, dynamic> json) => responseData20(
        data: paymentURL.fromJson(json["data"]),
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

class paymentURL {
  paymentURL({required this.url});

  String url;

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

  factory paymentURL.fromJson(Map<String, dynamic> json) =>
      paymentURL(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}
