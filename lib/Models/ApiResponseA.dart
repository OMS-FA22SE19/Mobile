class ApiResponseA<T> {
  ApiResponseA({required this.data});

  T data;

  // factory ApiResponseA.fromJson(Map<String, dynamic> json) => ApiResponseA(
  //       data: json["data"],
  //       succeeded: json["succeeded"],
  //       statusCode: json["statusCode"],
  //       message: json["message"],
  //     );

  factory ApiResponseA.fromJson(List<dynamic> json) => ApiResponseA<T>(
        data: ApiResponseA<T>.fromJson(json) as T,
      );

  Map<String, dynamic> toJson() => {"data": data};
}
