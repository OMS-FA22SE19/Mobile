// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oms_mobile/Models/available_date.dart';
import 'package:oms_mobile/Models/course_type.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/Models/food_type.dart';
import 'package:oms_mobile/Models/menu.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/orderDetail.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/table.dart';
import 'package:oms_mobile/Models/table_type.dart';
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

  // Future<List<courseType>?> getCourseTypes() async {
  //   final Dio dio = Dio();
  //   HttpOverrides.global = MyHttpOverrides();
  //   try {
  //     Response response = await dio
  //         .get('https://10.0.2.2:7246//api/v1/CourseTypes'); //header, author
  //     var result = responseData.fromJson(response.data);
  //     List<courseType> courses = result.data;
  //     return courses;
  //   } on DioError catch (e) {
  //     if (e.response?.statusCode == 404) {
  //       return null;
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  // Future<List<foodType>?> getFoodTypes() async {
  //   final Dio dio = Dio();
  //   HttpOverrides.global = MyHttpOverrides();
  //   try {
  //     Response response =
  //         await dio.get('https://10.0.2.2:7246/api/v1/Types'); //header, author
  //     var result = responseData2.fromJson(response.data);
  //     List<foodType> types = result.data;
  //     return types;
  //   } on DioError catch (e) {
  //     if (e.response?.statusCode == 404) {
  //       return null;
  //     } else {
  //       return null;
  //     }
  //   }
  // }

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

  Future<List<food>?> getFoods(
      int menuId, int categoryId, bool isCourse) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response;
      if (isCourse) {
        response = await dio.get(
            'https://10.0.2.2:7246/api/v1/Menus/$menuId/Food?courseTypeId=$categoryId');
      } else {
        response = await dio.get(
            'https://10.0.2.2:7246/api/v1/Menus/$menuId/Food?typeId=$categoryId');
      }
      var result = responseData3.fromJson(response.data);
      List<food> foods = result.data;
      return foods;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<foodWithoutPrice>? getFood(String? foodId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .get('https://10.0.2.2:7246/api/v1/Foods/$foodId'); //header, author
      var result = responseData12.fromJson(response.data);
      foodWithoutPrice gotFood = result.data;
      return gotFood;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return foodWithoutPrice(
            id: 1,
            name: "0",
            available: false,
            description: "0",
            ingredient: "0",
            pictureUrl: "0",
            isDeleted: false,
            quantity: 1);
      } else {
        return foodWithoutPrice(
            id: 1,
            name: "0",
            available: false,
            description: "0",
            ingredient: "0",
            pictureUrl: "0",
            isDeleted: false,
            quantity: 1);
      }
    }
  }

  Future<Order> getOrders(String? orderId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .get('https://10.0.2.2:7246/api/v1/Orders/$orderId'); //header, author
      var result = responseData15.fromJson(response.data);
      Order gotOrder = result.data;
      return gotOrder;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Order(
            id: "0",
            userId: "0",
            phoneNumber: "0",
            fullName: "",
            date: "0",
            status: "0",
            prePaid: 1,
            total: 1,
            orderDetails: []);
      } else {
        return Order(
            id: "0",
            userId: "0",
            phoneNumber: "0",
            fullName: "",
            date: "0",
            status: "0",
            prePaid: 1,
            total: 1,
            orderDetails: []);
      }
    }
  }

  Future<Order>? getOrder(String? orderId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .get('https://10.0.2.2:7246/api/v1/Orders/$orderId'); //header, author
      var result = responseData15.fromJson(response.data);
      Order gotOrder = result.data;

      return gotOrder;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Order(
            id: "0",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      } else {
        return Order(
            id: "0",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      }
    }
  }

  Future<List<orderDetail>?> getOrdersDetails(String? orderId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/OrderDetails?SearchValue=$orderId'); //header, author
      var result = responseData10.fromJson(response.data);
      List<orderDetail> foods = result.data;
      return foods;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<Order>? createOrder(int reservationId, List<food>? foods) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    Map<String, Detail> map1 = {
      for (var e in foods!)
        e.id.toString(): Detail(quantity: e.quantity, note: e.note)
    };
    var formData =
        PostFood(reservationId: reservationId, orderDetails: map1).toJson();
    try {
      final response =
          await dio.post('https://10.0.2.2:7246/api/v1/Orders', data: formData);
      var result = responseData15.fromJson(response.data);
      Order orders = result.data;
      return orders;
      //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Order(
            id: "create Order 1",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      } else {
        return Order(
            id: "create Order 2",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      }
    }
  }

  Future<Order>? putOrder(String orderId, List<food>? foods) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    Map<String, Detail> map1 = {
      for (var e in foods!)
        e.id.toString(): Detail(quantity: e.quantity, note: e.note)
    };
    var formData = PutFood(orderId: orderId, orderDetails: map1).toJson();
    try {
      final response = await dio
          .put('https://10.0.2.2:7246/api/v1/Orders/AddDishes', data: formData);
      var result = responseData15.fromJson(response.data);
      Order orders = result.data;
      return orders;
      //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return Order(
            id: "Put order",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      } else {
        return Order(
            id: "Put order",
            userId: "0",
            date: "0",
            fullName: "0",
            phoneNumber: "0",
            prePaid: 0,
            status: "0",
            total: 0,
            orderDetails: []);
      }
    }
  }

  void checkingOrder(String id) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.put(
          'https://10.0.2.2:7246/api/v1/Orders/$id/Check'); //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  void foodCancelled(String id) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.put(
          'https://10.0.2.2:7246/api/v1/OrderDetails/$id',
          data: {"id": id, "status": "Cancelled"}); //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<menu>?> getMenuAvailable() async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response =
          await dio.get('https://10.0.2.2:7246/api/v1/Menus'); //header, author
      var result = responseData8.fromJson(response.data);
      List<menu> menus = result.data;
      return menus;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<tableAvailable>?> getTablesAvailable(int numberOfPeople) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Tables/People/$numberOfPeople'); //header, author
      var result = responseData25.fromJson(response.data);
      List<tableAvailable> tables = result.data;
      return tables;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<int> getTableChargePerSeat(int typeId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/TableTypes/$typeId'); //header, author
      var result = responseTableType.fromJson(response.data);
      int chargePerSeat = result.data.chargePerSeat;
      return chargePerSeat;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return 0;
      } else {
        return 0;
      }
    }
  }

  Future<String> getTableTypeName(int typeId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/TableTypes/$typeId'); //header, author
      var result = responseTableType.fromJson(response.data);
      String name = result.data.name;
      return name;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return "";
      } else {
        return "";
      }
    }
  }

  Future<List<availableDate>?> getTimeAvailable(
      int numberOfSeats, int tableTypeId, String date, int quantity) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Reservations/BusyDate?date=$date&NumOfSeats=$numberOfSeats&TableTypeId=$tableTypeId&Quantity=$quantity'); //header, author
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

  Future<List<Order>?> getOrdersHistory() async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Orders?Status=Paid'); //header, author
      var result = ResponseOrder.fromJson(response.data);
      List<Order> orderList = result.data;

      final response_2 = await dio.get(
          'https://10.0.2.2:7246/api/v1/Orders?Status=Processing'); //header, author
      var result_2 = ResponseOrder.fromJson(response_2.data);
      List<Order> orderList_2 = result_2.data;

      final response_3 = await dio.get(
          'https://10.0.2.2:7246/api/v1/Orders?Status=Checking'); //header, author
      var result_3 = ResponseOrder.fromJson(response_3.data);
      List<Order> orderList_3 = result_3.data;

      List<Order> orderList_total = orderList + orderList_2 + orderList_3;
      return orderList_total;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<ReservationNoTable>?> getReservationsHistory() async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .get('https://10.0.2.2:7246/api/v1/Reservations'); //header, author
      var result = responseReservation.fromJson(response.data);
      List<ReservationNoTable> reservationList = result.data;
      return reservationList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<List<ReservationNoTable>?> getReservationsBeforeCheckin(
      String status) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Reservations?Status=$status'); //header, author
      var result = responseReservation.fromJson(response.data);
      List<ReservationNoTable> reservationList = result.data;
      var finalList = reservationList;
      return finalList;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<ReservationNoTable>? getReservationBeforeCheckin(int id) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.get(
          'https://10.0.2.2:7246/api/v1/Reservations/$id'); //header, author
      var result = responseOneReservation.fromJson(response.data);
      ReservationNoTable reservation = result.data;
      return reservation;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return ReservationNoTable(
          id: 0,
          userId: "",
          numOfPeople: 0,
          numOfSeats: 0,
          quantity: 0,
          tableType: "",
          tableTypeId: 0,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          status: "",
          prePaid: 0,
          paid: 0,
          isPriorFoodOrder: false,
          user: User(
              id: "",
              userName: "",
              fullName: "",
              phoneNumber: "",
              isDeleted: true),
          reservationTables: [],
        );
      } else {
        return ReservationNoTable(
          id: 0,
          userId: "",
          numOfPeople: 0,
          numOfSeats: 0,
          quantity: 0,
          tableType: "",
          tableTypeId: 0,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          status: "",
          prePaid: 0,
          paid: 0,
          isPriorFoodOrder: false,
          user: User(
              id: "",
              userName: "",
              fullName: "",
              phoneNumber: "",
              isDeleted: true),
          reservationTables: [],
        );
      }
    }
  }

  void cancelReservation(int? id) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.delete(
          'https://10.0.2.2:7246/api/v1/Reservations/$id'); //header, author
      // var result = responseData20.fromJson(response.data);
      // paymentURL returnURL = result.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return;
      } else {
        return;
      }
    }
  }

  void checkinReservation() async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.post(
          'https://10.0.2.2:7246/api/v1/Reservations/Checkin',
          data: {}); //header, author
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return;
      } else {
        return;
      }
    }
  }

  Future<int>? createReservations(String start, String end, int numberOfSeats,
      int numberOfPeople, int tableTypeId, int quantity) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response =
          await dio.post('https://10.0.2.2:7246/api/v1/Reservations', data: {
        "startTime": start,
        "endTime": end,
        "numOfPeople": numberOfPeople,
        "numOfSeats": numberOfSeats,
        "tableTypeId": tableTypeId,
        "quantity": quantity
      });
      // var result = responseOneReservation.fromJson(response.data);
      // ReservationNoTable reservation = result.data;
      // return reservation.id;
      var result = response.data.toString();
      String returnId = result.toString().substring(12, 14).trim();
      return int.parse(returnId);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return 0;
        // ReservationNoTable(
        //     id: 0,
        //     userId: '${e.response?.statusCode}',
        //     numOfPeople: 0,
        //     tableTypeId: 0,
        //     tableType: "404",
        //     numOfSeats: 0,
        //     quantity: quantity,
        //     startTime: DateTime.now(),
        //     endTime: DateTime.now(),
        //     status: "",
        //     isPriorFoodOrder: false,
        //     user: User(
        //         id: "",
        //         userName: "",
        //         fullName: "",
        //         phoneNumber: "",
        //         isDeleted: false),
        //     prePaid: 0);
      } else {
        return 0;
      }
    }
  }

  void updateReservations(
      String start,
      String end,
      int numberOfSeats,
      int numberOfPeople,
      int tableTypeId,
      int quantity,
      int? reservationId) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.put(
          'https://10.0.2.2:7246/api/v1/Reservations/$reservationId',
          data: {
            "id": reservationId,
            "startTime": start,
            "endTime": end,
            "numOfPeople": numberOfPeople,
            "numOfSeats": numberOfSeats,
            "tableTypeId": tableTypeId,
            "quantity": quantity
          });
      // var result = response.data.toString();
      // String returnId = result.toString().substring(12, 14).trim();
      // return int.parse(returnId);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return;
      } else {
        return;
      }
    }
  }

  void createPreorderFood(int reservationId, List<food>? foods) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    Map<String, Detail> map1 = {
      for (var e in foods!)
        e.id.toString(): Detail(quantity: e.quantity, note: e.note)
    };
    var formData =
        PostFood(reservationId: reservationId, orderDetails: map1).toJson();
    try {
      final response = await dio.post(
          'https://10.0.2.2:7246/api/v1/Orders/PriorFood',
          data: formData);
      var result = responseData15.fromJson(response.data);
      result.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return;
      } else {
        return;
      }
    }
  }

  void updatePreorderFood(int reservationId, List<food>? foods) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    Map<String, Detail> map1 = {
      for (var e in foods!)
        e.id.toString(): Detail(quantity: e.quantity, note: e.note)
    };
    var formData =
        PostFood(reservationId: reservationId, orderDetails: map1).toJson();
    try {
      final response = await dio.put(
          'https://10.0.2.2:7246/api/v1/Orders/PriorFood/$reservationId',
          data: formData);
      var result = responseData15.fromJson(response.data);
      result.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return;
      } else {
        return;
      }
    }
  }

  Future<paymentURL>? getPaymentURL(String? orderId, int? total) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio.post(
          'https://10.0.2.2:7246/api/v1/VNPay/Order',
          data: {"Amount": total, "OrderId": orderId}); //header, author
      var result = responseData20.fromJson(response.data);
      paymentURL returnURL = result.data;
      return returnURL;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return paymentURL(url: "NULL URL");
      } else {
        return paymentURL(url: "NULL URL");
      }
    }
  }

  Future<paymentURL>? getPaymentURLReservation(
      int? reservationId, int? total) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      final response = await dio
          .post('https://10.0.2.2:7246/api/v1/VNPay/Reservation', data: {
        "Amount": total,
        "reservationId": reservationId
      }); //header, author
      var result = responseData20.fromJson(response.data);
      paymentURL returnURL = result.data;
      return returnURL;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return paymentURL(url: "NULL URL");
      } else {
        return paymentURL(url: "NULL URL");
      }
    }
  }

  void postFCMtoken(String userId, String deviceToken) async {
    final Dio dio = Dio();
    HttpOverrides.global = MyHttpOverrides();
    try {
      await dio.post('https://10.0.2.2:7246/api/v1/UserDeviceTokens', data: {
        "userId": userId,
        "deviceToken": deviceToken,
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

class PostFood {
  PostFood({
    required this.reservationId,
    required this.orderDetails,
  });

  int reservationId;
  Map<String, Detail> orderDetails;

  factory PostFood.fromJson(Map<String, dynamic> json) => PostFood(
        reservationId: json["reservationId"],
        orderDetails: Map.from(json["orderDetails"])
            .map((k, v) => MapEntry<String, Detail>(k, Detail.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "reservationId": reservationId,
        "orderDetails": Map.from(orderDetails)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class PutFood {
  PutFood({
    required this.orderId,
    required this.orderDetails,
  });

  String orderId;
  Map<String, Detail> orderDetails;

  factory PutFood.fromJson(Map<String, dynamic> json) => PutFood(
        orderId: json["orderId"],
        orderDetails: Map.from(json["orderDetails"])
            .map((k, v) => MapEntry<String, Detail>(k, Detail.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDetails": Map.from(orderDetails)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Detail {
  Detail({
    required this.quantity,
    required this.note,
  });

  int quantity;
  String note;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        quantity: json["quantity"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "note": note,
      };
}
