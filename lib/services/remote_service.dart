import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oms_mobile/Models/available_date.dart';
// import 'package:http/http.dart' as http;
import 'package:oms_mobile/Models/course_type.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/Models/food_type.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/table.dart';
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

class RemoteService {
  Future<List<courseType>?> getCourseTypes() async {
    final Dio dio = Dio();
    // var client = http.Client();

    // var uri = Uri.parse('https://10.0.2.2:7246/api/v1/CourseTypes');

    HttpOverrides.global = MyHttpOverrides();
    Response response = await dio
        .get('https://10.0.2.2:7246/api/v1/CourseTypes'); //header, author
    var result = responseData.fromJson(response.data);
    List<courseType> courseTypes = result.data;
    return courseTypes;
  }

  Future<List<foodType>?> getFoodTypes() async {
    final Dio dio = Dio();
    // var client = http.Client();

    // var uri = Uri.parse('https://10.0.2.2:7246/api/v1/Types');

    HttpOverrides.global = MyHttpOverrides();
    Response response =
        await dio.get('https://10.0.2.2:7246/api/v1/Types'); //header, author
    var result = responseData2.fromJson(response.data);
    List<foodType> foodTypes = result.data;
    return foodTypes;
  }

  Future<List<food>?> getFoods() async {
    final Dio dio = Dio();
    // var client = http.Client();

    // var uri = Uri.parse('https://10.0.2.2:7246/api/v1/Types');

    HttpOverrides.global = MyHttpOverrides();
    Response response =
        await dio.get('https://10.0.2.2:7246/api/v1/Foods'); //header, author
    var result = responseData3.fromJson(response.data);
    List<food> foods = result.data;
    return foods;
  }

  Future<List<table>?> getTablesAvailable(int numberOfPeople) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Tables/people/$numberOfPeople'); //header, author
      var result = responseData5.fromJson(response.data);
      List<table> tables = result.data;
      return tables;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<availableDate>?> getTimeAvailable(
      int numberOfSeats, int tableTypeId, String date) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Reservations/BusyDate?date=$date&NumOfSeats=$numberOfSeats&TableTypeId=$tableTypeId'); //header, author
      var result = responseData6.fromJson(response.data);
      List<availableDate> dateList = result.data;
      return dateList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<reservation>?> getReservations() async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .get('https://10.0.2.2:7246/api/v1/Reservations'); //header, author
      var result = responseData7.fromJson(response.data);
      List<reservation> reservationList = result.data;
      return reservationList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  void createReservations(String start, String end, int numberOfSeats,
      int tableTypeId, bool isPriorFoodOrder) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response =
          await dio.post('https://10.0.2.2:7246/api/v1/Reservations', data: {
        "startTime": start,
        "endTime": end,
        "numOfSeats": numberOfSeats,
        "tableTypeId": tableTypeId,
        "isPriorFoodOrder": false
      }); //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }
}
