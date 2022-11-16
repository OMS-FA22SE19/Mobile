// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/order_confirm.dart';
import 'package:oms_mobile/Models/orderDetail.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

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
  var isLoaded = false;
  var flag = true;
  var isCancel = false;

  @override
  void initState() {
    super.initState();
    checkStatusOrder();
    getData();
  }

  checkStatusOrder() {
    orderDetails?.forEach((element) {
      if (element.status.contains("Processing") ||
          element.status.contains("Received")) {
        flag = true;
      } else {
        if (element.status.contains("Processing") ||
            element.status.contains("Cancelled") ||
            element.status.contains("Served")) {
          isCancel = false;
        } else {
          isCancel = true;
        }
        flag = false;
      }
    });
  }

  getData() async {
    orderDetails = await RemoteService().getOrdersDetails(widget.orderId);
    if (orderDetails != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(232, 192, 125, 100),
          centerTitle: true,
          title: Text("Order",
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
        ),
        backgroundColor: Colors.grey[200],
        body: Visibility(
          visible: isLoaded,
          // child: Center(
          //   child: Container(
          //     width: 300,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: orderDetails?.length,
            // padding: EdgeInsets.all(10),
            // scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Note",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          orderDetails![index].note,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 150,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderDetails![index].foodName,
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
                                    'Price: ' +
                                        changeFormat(
                                            orderDetails![index].price),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cabin(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    'Id: ' + orderDetails![index].id.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cabin(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      statusBar(orderDetails![index].status),
                                      cancelFood(orderDetails![index].status,
                                          orderDetails![index].id),
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
          //   ),
          // ),
        ),
        floatingActionButton: conditionalFloatingActionButton(
            orderDetails?.elementAt(1).orderId));
  }

  conditionalFloatingActionButton(String? id) {
    if (flag) {
      return FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        label: Text(
          "Reload",
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
        icon: Icon(
          Icons.refresh_rounded,
          size: 35,
        ),
        onPressed: () {
          setState(() {
            checkStatusOrder();
            getData();
          });
        },
      );
    } else {
      return FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        label: Text(
          "Confirm",
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
            status,
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
            status,
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
            status,
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
            status,
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
            getData();
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
