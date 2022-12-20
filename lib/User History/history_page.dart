// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/User%20History/history_order_detail.dart';
import 'package:oms_mobile/User%20History/history_reservation_detail.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class historyPage extends StatefulWidget {
  final String jwtToken;
  const historyPage({super.key, required this.jwtToken});

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  List<ReservationNoTable>? reservationList;
  List<Order>? orderList;
  var isLoadedOrder = false;
  var isLoadedReservation = false;
  UserProfile? currentUser;

  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getReservationData();
    getOrderData();
    getUser();
  }

  getReservationData() async {
    reservationList =
        await RemoteService().getReservationsCancelled(widget.jwtToken);
    if (reservationList != null) {
      if (mounted) {
        setState(() {
          isLoadedReservation = true;
        });
      }
    }
  }

  getOrderData() async {
    orderList = await RemoteService().getOrdersHistory(widget.jwtToken);
    if (orderList != null) {
      if (mounted) {
        setState(() {
          isLoadedOrder = true;
        });
      }
    }
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor:
                    (currentUser?.userName.contains("defaultCustomer") ?? false)
                        ? const Color.fromRGBO(232, 192, 125, 100)
                        : Colors.blue[600],
                centerTitle: true,
                title: Text('history'.tr,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 25,
                    )),
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  indicatorColor:
                      (currentUser?.userName.contains("defaultCustomer") ??
                              false)
                          ? const Color.fromRGBO(232, 192, 125, 100)
                          : Colors.blue[600],
                  indicatorWeight: 2.5,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      text: 'Orders'.tr,
                      icon: const Icon(Icons.restaurant_rounded),
                    ),
                    Tab(
                      text: 'Cancelled Reservation'.tr,
                      icon: const Icon(Icons.restaurant_rounded),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.grey[200],
              body: TabBarView(children: [
                Visibility(
                  visible: isLoadedOrder,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getReservationData();
                        getOrderData();
                      });
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: orderList?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => historyDetailOrder(
                                        jwtToken: widget.jwtToken,
                                        orderId: orderList![index].id,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (currentUser?.userName
                                                          .contains(
                                                              "defaultCustomer") ??
                                                      false)
                                                  ? const Color.fromRGBO(
                                                      232, 192, 125, 100)
                                                  : Colors.blue[600],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.restaurant_menu_rounded,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderList![index].status.tr,
                                                style: GoogleFonts.cabin(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                orderList![index]
                                                    .date
                                                    .substring(0, 10),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                '${'Deposit money:'.tr} ${changeFormat(orderList![index].prePaid)}đ',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${changeFormat(orderList![index].total)}đ',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoadedReservation,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        getReservationData();
                        getOrderData();
                      });
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: reservationList?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      historyDetailReservation(
                                        jwtToken: widget.jwtToken,
                                        reservationId:
                                            reservationList![index].id,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (currentUser?.userName
                                                          .contains(
                                                              "defaultCustomer") ??
                                                      false)
                                                  ? const Color.fromRGBO(
                                                      232, 192, 125, 100)
                                                  : Colors.blue[600],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.restaurant_menu_rounded,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reservationList![index]
                                                    .status
                                                    .tr,
                                                style: GoogleFonts.cabin(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                reservationList![index]
                                                    .startTime
                                                    .toString()
                                                    .substring(0, 10),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${'Paid'.tr} : ${reservationList![index].paid}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${changeFormat(reservationList![index].prePaid)}đ',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
