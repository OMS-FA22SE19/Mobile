// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';
import 'package:oms_mobile/Menu%20Order/order_confirm.dart';
import 'package:oms_mobile/Models/orderDetail.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuStatus extends StatefulWidget {
  final int tableId;
  final String? orderId;
  final bool isCourse;
  const menuStatus(
      {super.key,
      required this.orderId,
      required this.isCourse,
      required this.tableId});

  @override
  State<menuStatus> createState() => _menuStatusState();
}

class _menuStatusState extends State<menuStatus> {
  List<orderDetail>? orderDetails;
  var isLoaded = false;
  var flag = true;

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
                        builder: (context) =>
                            menuCategory(tableId: widget.tableId)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => menuFood(
                              tableId: widget.tableId,
                              isCourse: widget.isCourse,
                              categoryId: 1,
                            )),
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
                                        orderDetails![index].price.toString(),
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
                                  statusBar(orderDetails![index].status)
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
                      tableId: widget.tableId,
                    )),
          );
        },
      );
    }
  }

  statusBar(String status) {
    if (status.contains("Cancelled")) {
      return InkWell(
        onTap: () {
          // setState(() {
          //   foods![index].quantity =
          //       foods![index].quantity + 1;
          // });
        },
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
        onTap: () {
          // setState(() {
          //   foods![index].quantity =
          //       foods![index].quantity + 1;
          // });
        },
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
}
