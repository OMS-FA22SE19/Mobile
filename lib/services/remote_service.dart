import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:oms_mobile/Models/ApiResponseA.dart';
import 'package:oms_mobile/Models/food_category.dart';
import 'package:oms_mobile/main.dart';

// class RemoteService {
//   Future<List<Datum>?> getCategories() async {
//     final Dio dio = new Dio();
//     var client = http.Client();

//     var uri = Uri.parse('https://10.0.2.2:7246/api/v1/Categories');
// //10.0.2.2

//     HttpOverrides.global = MyHttpOverrides();
//     var response = await dio
//         .get('https://10.0.2.2:7246/api/v1/Categories'); //header, author

//     if (response.statusCode == 200) {
//       // var json = response.data;
//       // return categoriesFromJson(json);
//       print(response);
//       Map<String, dynamic> map = response.data;
//       // Map<String, dynamic> map = json.decode(response.data);
//       List<Datum> data = map['data'];
//       // List<Datum> data =
//       //     (map["data"] as List).map((item) => item as Datum).toList();
//       // List<dynamic> data = List<Datum>.from(map['data'] as List);
//       // List<Datum> returnedData = data as List<Datum>;
//       return data;
//     }
//     return null;
//   }
// }

class ARemoteService {
  Future<void> getCategories() async {
    final Dio dio = new Dio();
    var client = http.Client();

    var uri = Uri.parse('https://10.0.2.2:7246/api/v1/Categories');
//10.0.2.2

    HttpOverrides.global = MyHttpOverrides();
    Response response = await dio
        .get('https://10.0.2.2:7246/api/v1/Categories'); //header, author
    Map<String, dynamic> map = response.data;
    List<dynamic> x = map["data"];
    if (response.statusCode == 200) {
      // var user = ApiResponseA<List<Datum>>.fromJson(x);
      // print(user);
    }
    var xasdasdasd = ApiResponseA.fromJson(json.decode(response.data));
    return null;
  }
}
