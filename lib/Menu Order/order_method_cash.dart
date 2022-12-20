// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/order_success.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class orderMethod extends StatefulWidget {
  final String jwtToken;
  final String? orderId;
  final String method;
  final int reservationId;

  const orderMethod(
      {super.key,
      required this.orderId,
      required this.method,
      required this.reservationId,
      required this.jwtToken});

  @override
  State<orderMethod> createState() => _orderMethodState();
}

class _orderMethodState extends State<orderMethod> {
  bool flag = false;
  Order? currentOrder;
  List<OrderDetail>? details;
  var isLoaded = false;
  int total = 0;

  UserProfile? currentUser;
  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getData();
    getUser();
  }

  NotifyStaff() async {
    ReservationNoTable? currentReservation = await RemoteService()
        .getReservationBeforeCheckin(widget.reservationId, widget.jwtToken);
    RemoteService().postNotification(
        currentReservation?.reservationTables.elementAt(0).tableId.toString(),
        "e0ysZAelsc0wpu3gshn-lU:APA91bFOTjAqLagOakF2_w0bV81HsEiFJroE0jPzuUEVdanFPW8WK7Ge8wRaS1aW9-bAFwV-895d6kjOnHZIaiXfI41dlG-hyx71X6JtT6AjNGtI4Mw4slz5TEjfSle17nHk3ZL3lsSh",
        widget.jwtToken);
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  getData() async {
    currentOrder =
        await RemoteService().getOrders(widget.orderId, widget.jwtToken);
    flag = currentOrder?.status.contains("Paid") ?? false;
    details = currentOrder?.orderDetails;
    if (currentOrder != null) {
      setState(() {
        isLoaded = true;
        total = (currentOrder?.total ?? 0) + (currentOrder?.prePaid ?? 0);
      });
    }
  }

  checkingOrder() {
    RemoteService().checkingOrder(widget.orderId ?? "", widget.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            (currentUser?.userName.contains("defaultCustomer") ?? false)
                ? const Color.fromRGBO(232, 192, 125, 100)
                : Colors.blue[600],
        centerTitle: true,
        title: Text("Order".tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        homeScreen(jwtToken: widget.jwtToken)),
              );
            },
            icon: const Icon(
              Icons.home_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                getData();
              },
              icon: const Icon(
                Icons.refresh_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: details?.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 180,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentUser?.userName.contains("defaultCustomer") ??
                            false)
                        ? const Color.fromRGBO(232, 192, 125, 100)
                        : Colors.blue[600],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: 150,
                              child: const Icon(
                                Icons.lunch_dining_rounded,
                                size: 120,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  details![index].foodName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '${'Price'.tr}: ${changeFormat(details![index].price)} đ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 18, color: Colors.white),
                                ),
                                // Text(
                                //   'Quantity: ' +
                                //       details![index].quantity.toString(),
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: GoogleFonts.cabin(
                                //       fontSize: 18, color: Colors.white),
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.brown[600],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    '${'Amount'.tr}: ${details![index].quantity.toString()}',
                                    style: GoogleFonts.cabin(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
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
      bottomNavigationBar: BottomAppBar(
        // ignore: sort_child_properties_last
        child: Container(
          height: 120,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  '${'Payment Method'.tr}: ${widget.method}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(100),
                            1: FixedColumnWidth(150),
                          },
                          children: <TableRow>[
                            TableRow(children: [
                              Text(
                                '${'Total Pay'.tr}: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${changeFormat(total)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '${'deposit'.tr}: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '- ${changeFormat(currentOrder?.prePaid ?? 0)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '${'Must pay'.tr}: ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${changeFormat(currentOrder?.total ?? 0)}đ',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (flag == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orderSuccess(
                                        reservationId: widget.reservationId,
                                        jwtToken: widget.jwtToken,
                                        orderId: widget.orderId ?? "",
                                      )),
                            );
                          } else {
                            checkingOrder();
                            NotifyStaff();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Remind'.tr,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'A staff will come and checked-out the order for you! Please wait and don\'t push any button!'
                                        .tr,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: Text('I understand'.tr),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: (currentUser?.userName
                                          .contains("defaultCustomer") ??
                                      false)
                                  ? const Color.fromRGBO(232, 192, 125, 100)
                                  : Colors.blue[600],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: conditionalButton(),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  conditionalButton() {
    if (flag) {
      return Text(
        'View Bill'.tr,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.cabin(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      );
    } else {
      return Text(
        'Process'.tr,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.cabin(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      );
    }
  }
}
