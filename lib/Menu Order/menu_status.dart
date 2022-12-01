// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/order_confirm.dart';
import 'package:oms_mobile/Models/orderDetail.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class menuStatus extends StatefulWidget {
  final int reservationId;
  final String? orderId;
  bool? isCourse;
  menuStatus(
      {super.key,
      required this.orderId,
      this.isCourse,
      required this.reservationId});

  @override
  State<menuStatus> createState() => _menuStatusState();
}

class _menuStatusState extends State<menuStatus> {
  List<orderDetail>? orderDetails;
  List<orderDetail>? receivedList;
  List<orderDetail>? processingList;
  List<orderDetail>? servedList;
  String? abc;
  var isLoaded = false;
  var isLoaded_1 = false;
  var isLoaded_2 = false;
  var isLoaded_3 = false;
  var flag = true;
  var isCancel = false;

  @override
  void initState() {
    super.initState();
    checkStatusOrder();
    // getData();
    getDataReceived();
    getDataProcess();
    getDataServed();
  }

  checkStatusOrder() {
    // orderDetails?.forEach((element) {
    //   if (element.status.contains("Processing") ||
    //       element.status.contains("Received")) {
    //     flag = true;
    //   } else {
    //     if (element.status.contains("Processing") ||
    //         element.status.contains("Cancelled") ||
    //         element.status.contains("Served")) {
    //       isCancel = false;
    //     } else {
    //       isCancel = true;
    //     }
    //     flag = false;
    //   }
    // });

    if (receivedList?.length == 0) {
      if (processingList?.length == 0) {
        setState(() {
          flag = false;
        });
      }
    }
  }

  getDataReceived() async {
    receivedList =
        await RemoteService().getOrdersDetails(widget.orderId, "Received");
    if (receivedList?.length != 0) {
      setState(() {
        isLoaded_1 = true;
      });
    }
  }

  getDataProcess() async {
    processingList =
        await RemoteService().getOrdersDetails(widget.orderId, "Processing");
    if (processingList?.length != 0) {
      setState(() {
        isLoaded_2 = true;
      });
    }
  }

  getDataServed() async {
    servedList =
        await RemoteService().getOrdersDetails(widget.orderId, "Served");
    if (servedList?.length != 0) {
      setState(() {
        isLoaded_3 = true;
      });
    }
  }

  // getData() async {
  //   orderDetails =
  //       await RemoteService().getOrdersDetails(widget.orderId, "Received");
  //   if (orderDetails != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(232, 192, 125, 100),
            centerTitle: true,
            title: Text('Order'.tr,
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                )),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                )),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => menuCategory(
                                reservationId: widget.reservationId,
                                isCourse: widget.isCourse,
                                orderId: widget.orderId,
                              )),
                    );
                  },
                  icon: Icon(
                    Icons.menu_book_rounded,
                    size: 30,
                  )),
            ],
            bottom: TabBar(
              indicatorColor: Color.fromRGBO(232, 192, 125, 100),
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'Received'.tr,
                  icon: const Icon(Icons.restaurant_rounded),
                ),
                Tab(
                  text: 'Processing'.tr,
                  icon: const Icon(Icons.restaurant_rounded),
                ),
                Tab(
                    text: 'Served'.tr,
                    icon: const Icon(Icons.restaurant_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: TabBarView(
            children: [
              //TAB1
              Visibility(
                visible: isLoaded_1,
                replacement: Center(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      getDataServed();
                      getDataProcess();
                      getDataReceived();
                    });
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: receivedList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'note'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  receivedList![index].note,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 180,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(232, 192, 125, 100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        child: Icon(
                                          Icons.lunch_dining_rounded,
                                          size: 120,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            receivedList![index].foodName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            '${'Price'.tr}: ${changeFormat(receivedList![index].price)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          // Text(
                                          //   '${'Amount'.tr}: ${receivedList![index].status}',
                                          //   maxLines: 1,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: GoogleFonts.cabin(
                                          //       fontSize: 18,
                                          //       color: Colors.white),
                                          // ),
                                          Text(
                                            'Id: ${receivedList![index].id}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              statusBar(
                                                  receivedList![index].status),
                                              cancelFood(
                                                  receivedList![index].status,
                                                  receivedList![index].id),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////////////
              //TAB2
              Visibility(
                visible: isLoaded_2,
                replacement: Center(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      getDataServed();
                      getDataProcess();
                      getDataReceived();
                    });
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: processingList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'note'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  processingList![index].note,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 180,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(232, 192, 125, 100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        child: Icon(
                                          Icons.lunch_dining_rounded,
                                          size: 120,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            processingList![index].foodName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            '${'Price'.tr}: ${changeFormat(processingList![index].price)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Id: ${processingList![index].id}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              statusBar(processingList![index]
                                                  .status),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              //TAB3
              Visibility(
                visible: isLoaded_3,
                replacement: Center(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      getDataServed();
                      getDataProcess();
                      getDataReceived();
                    });
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: servedList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'note'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  servedList![index].note,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 180,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(232, 192, 125, 100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        child: Icon(
                                          Icons.lunch_dining_rounded,
                                          size: 120,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            servedList![index].foodName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            '${'Price'.tr}: ${changeFormat(servedList![index].price)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Id: ${servedList![index].id}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cabin(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              statusBar(
                                                  servedList![index].status),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton:
              conditionalFloatingActionButton(widget.orderId)),
    ));
  }

  conditionalFloatingActionButton(String? id) {
    if (flag) {
      return FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        label: Text(
          'Reload'.tr,
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
        icon: Icon(
          Icons.refresh_rounded,
          size: 35,
        ),
        onPressed: () {
          setState(() {
            checkStatusOrder();
            getDataProcess();
            getDataReceived();
            getDataServed();
          });
        },
      );
    } else {
      return FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        label: Text(
          'CONFIRM'.tr,
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
        icon: Icon(
          Icons.check_circle_rounded,
          size: 35,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => orderConfirm(
                      orderId: id,
                      reservationId: widget.reservationId,
                    )),
          );
        },
      );
    }
  }

  statusBar(String status) {
    if (status.contains("Cancelled")) {
      return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.red[600], borderRadius: BorderRadius.circular(10)),
          child: Text(
            status.tr,
            style: GoogleFonts.cabin(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    } else if (status.contains("Received")) {
      return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.blue[600], borderRadius: BorderRadius.circular(10)),
          child: Text(
            status.tr,
            style: GoogleFonts.cabin(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    } else if (status.contains("Processing")) {
      return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            status.tr,
            style: GoogleFonts.cabin(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            status.tr,
            style: GoogleFonts.cabin(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }
  }

  cancelFood(String status, int id) {
    if (status.contains("Received")) {
      return InkWell(
        onTap: () {
          setState(() {
            RemoteService().foodCancelled(id.toString());
            checkStatusOrder();
            getDataProcess();
            getDataReceived();
            getDataServed();
          });
        },
        child: Icon(
          Icons.highlight_remove_rounded,
          color: Colors.red,
        ),
      );
    } else {
      return Container(
        height: 1,
        width: 1,
      );
    }
  }
}
