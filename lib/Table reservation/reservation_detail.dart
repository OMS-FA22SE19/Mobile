// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/menu_status.dart';
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/qr_image.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/Table%20reservation/table_reservation_edit.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class reservationDetail extends StatefulWidget {
  final String jwtToken;
  final int id;
  const reservationDetail(
      {super.key, required this.id, required this.jwtToken});

  @override
  State<reservationDetail> createState() => _reservationDetailState();
}

class _reservationDetailState extends State<reservationDetail> {
  final depositController = TextEditingController();
  final cancelController = TextEditingController();
  ReservationNoTable? reservation;
  Order? currentOrder;
  UserProfile? currentUser;
  bool isLoaded = false;
  TimeOfDay nowTime = TimeOfDay.now();
  int tableId = 0;
  int moneyDeposit = 0;
  paymentURL? payment;
  bool flag = true;

  bool flagCancel = true;
  String errorCancel = "";
  String? check;

  @override
  void initState() {
    super.initState();
    getUser();
    getData();
  }

  cancelReservation() async {
    TimeOfDay nowTime = TimeOfDay.now();
    String createdHour = '${reservation?.created.toString().substring(11, 13)}';
    String createdMinute =
        '${reservation?.created.toString().substring(14, 16)}';
    TimeOfDay createdResTime = TimeOfDay(
        hour: int.parse(createdHour), minute: int.parse(createdMinute));

    double doubleCreatedTime = toDouble(createdResTime);
    double doubleNowTime = toDouble(nowTime);

    String createdYear = '${reservation?.created.toString().substring(0, 4)}';
    String createdMonth = '${reservation?.created.toString().substring(5, 7)}';
    String createdDate = '${reservation?.created.toString().substring(8, 11)}';
    int intYear = int.parse(createdYear);
    int intMonth = int.parse(createdMonth);
    int intDate = int.parse(createdDate);

    int nowDate = DateTime.now().day;
    int nowMonth = DateTime.now().month;
    int nowYear = DateTime.now().year;

    if (reservation?.status.contains("Available") ?? false) {
      if (nowYear <= intYear) {
        if (nowMonth <= intMonth) {
          if (nowDate <= intDate) {
            if (doubleCreatedTime < doubleNowTime) {
              RemoteService().cancelReservation(
                  widget.id, "Overtime for Payment", widget.jwtToken);
            }
          }
        }
      }
    }
  }

  cancelRes() async {
    check = await RemoteService().cancelReservation(
        reservation?.id, cancelController.text, widget.jwtToken);
  }

  getData() async {
    reservation = await RemoteService()
        .getReservationBeforeCheckin(widget.id, widget.jwtToken);
    currentOrder = await RemoteService()
        .getOrderByReservation(reservation?.id, widget.jwtToken);
    getVNPAYurl();
    getUser();
    cancelReservation();
    depositController.text = '${reservation?.prePaid}';
    if (reservation != null) {
      setState(() {
        isLoaded = true;
      });
    }
    if ((reservation?.orderDetails.length ?? 0) > 0) {
      setState(() {
        flag = false;
      });
    }
    if ((currentOrder?.orderDetails.length ?? 0) > 0) {
      setState(() {
        flag = false;
      });
    }
  }

  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  addBilling(int? reservationId) async {
    RemoteService()
        .addBillingReservation(reservationId, moneyDeposit, widget.jwtToken);
  }

  getVNPAYurl() async {
    payment = await RemoteService().getPaymentURLReservation(
        widget.id,
        (reservation?.prePaid ?? 0) - (reservation?.paid ?? 0),
        widget.jwtToken);
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  Widget build(BuildContext context) {
    return conditionalScaffold();
  }

  conditionalScaffold() {
    if (reservation?.status.contains("Cancelled") ?? true) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(232, 192, 125, 100),
          centerTitle: true,
          title: Text('detail'.tr,
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => reservationList(
                            jwtToken: widget.jwtToken,
                          )),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 30,
              )),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.grey[200],
        body: Visibility(
          visible: true,
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                getData();
              });
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: Container(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(232, 192, 125, 100),
          centerTitle: true,
          title: Text('detail'.tr,
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => reservationList(
                            jwtToken: widget.jwtToken,
                          )),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 30,
              )),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getData();
                  });
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
                          'You can checkin before 15 minutes of the start time of the reservation'
                              .tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text('I understand'.tr),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.info_outline_rounded,
                  size: 30,
                )),
            (reservation?.status.contains("Reserved") ?? false)
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRPage(
                                  id: widget.id,
                                  jwtToken: widget.jwtToken,
                                )),
                      );
                    },
                    icon: const Icon(
                      Icons.qr_code_rounded,
                      size: 30,
                    ))
                : IconButton(
                    onPressed: () {
                      (reservation?.orderDetails.length != 0)
                          ? showDialog(
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
                                    'Choose reservation information you want to edit'
                                        .tr,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  tableReservationEdit(
                                                    jwtToken: widget.jwtToken,
                                                    reservationId: widget.id,
                                                  )),
                                        );
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              alignment: Alignment.center,
                                              icon: const Icon(
                                                  Icons.info_outline_rounded),
                                              title: Text(
                                                'Remind'.tr,
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Please remember, any overcharged money won\'t be refund!'
                                                          .tr
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.lato(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'If you choose a different table type, table information might be changed'
                                                          .tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.lato(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child:
                                                      Text('I understand'.tr),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('table'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  menuCategory(
                                                      jwtToken: widget.jwtToken,
                                                      edit: true,
                                                      orderFood: true,
                                                      reservationId:
                                                          widget.id)),
                                        );
                                      },
                                      child: Text('food'.tr),
                                    ),
                                  ],
                                );
                              },
                            )
                          : showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.info_outline_rounded),
                                  title: Text(
                                    'Remind'.tr,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Please remember, any overcharged money won\'t be refund!'
                                              .tr
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'If you choose a different table type, table information might be changed'
                                              .tr,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  tableReservationEdit(
                                                    jwtToken: widget.jwtToken,
                                                    reservationId: widget.id,
                                                  )),
                                        );
                                      },
                                      child: Text('I understand'.tr),
                                    ),
                                  ],
                                );
                              },
                            );
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    )),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: Visibility(
          visible: true,
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                getData();
              });
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                // Container(
                //   color: Colors.grey[300],
                //   height: 20,
                // ),
                // Container(
                //   color: Colors.grey[200],
                //   child: Column(
                //     children: [
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         'YOUR RESERVATION',
                //         textAlign: TextAlign.center,
                //         maxLines: 2,
                //         style:
                //             GoogleFonts.cabin(fontSize: 30, color: Colors.black),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ((reservation?.status ?? "")
                                      .contains("Reserved"))
                                  ? Colors.yellow[600]
                                  : ((reservation?.status ?? "")
                                          .contains("Available"))
                                      ? Colors.blueAccent
                                      : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.restaurant_menu_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'status'.tr}:',
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                reservation?.status.tr ?? "",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       'Reservation information',
                //       textAlign: TextAlign.center,
                //       maxLines: 2,
                //       style: GoogleFonts.cabin(fontSize: 30, color: Colors.black),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ((reservation?.status ?? "")
                                        .contains("Reserved"))
                                    ? Colors.yellow[600]
                                    : ((reservation?.status ?? "")
                                            .contains("Available"))
                                        ? Colors.blueAccent
                                        : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.timer_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Center(
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FixedColumnWidth(170),
                                  1: FixedColumnWidth(110),
                                },
                                children: <TableRow>[
                                  TableRow(children: [
                                    Text(
                                      '${'date'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      reservation?.startTime
                                              .toString()
                                              .substring(0, 10)
                                              .replaceAll('-', '/') ??
                                          "",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      '${'Start Time'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      reservation?.startTime
                                              .toString()
                                              .substring(11, 16) ??
                                          "",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      '${'End Time'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      reservation?.endTime
                                              .toString()
                                              .substring(11, 16) ??
                                          "",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey[300],
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ((reservation?.status ?? "")
                                        .contains("Reserved"))
                                    ? Colors.yellow[600]
                                    : ((reservation?.status ?? "")
                                            .contains("Available"))
                                        ? Colors.blueAccent
                                        : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.table_restaurant_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Center(
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FixedColumnWidth(160),
                                  1: FixedColumnWidth(120),
                                },
                                children: <TableRow>[
                                  TableRow(children: [
                                    Text(
                                      '${'Number of people'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      reservation?.numOfPeople.toString() ?? "",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      '${'Number of seats'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      '${reservation?.numOfSeats.toString()} x ${reservation?.quantity.toString()}',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      '${'Type'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      reservation?.tableType ?? "",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      'Deposit money:'.tr,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      '${changeFormat(reservation?.prePaid ?? 0)}đ',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      '${'paid'.tr}:',
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      '${changeFormat(reservation?.paid ?? 0)}đ',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ]),
                                  ((reservation?.status ?? "")
                                          .contains("CheckIn"))
                                      ? TableRow(children: [
                                          Text(
                                            '${'table'.tr}:',
                                            style: GoogleFonts.cabin(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '${reservation?.reservationTables.elementAt(0).tableId}',
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.cabin(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ])
                                      : TableRow(children: [
                                          Text(
                                            '${'table'.tr}:',
                                            style: GoogleFonts.cabin(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'None'.tr,
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.cabin(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              ((reservation?.status ?? "").contains("Reserved"))
                                  ? Colors.yellow[600]
                                  : ((reservation?.status ?? "")
                                          .contains("Available"))
                                      ? Colors.blueAccent
                                      : Colors.greenAccent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(160),
                            1: FixedColumnWidth(120),
                          },
                          children: [
                            TableRow(children: [
                              Text(
                                'full name'.tr,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                // reservation?.user.fullName ?? "",
                                (currentUser?.userName
                                            .contains("defaultCustomer") ??
                                        false)
                                    ? '${reservation?.fullName}'
                                    : '${reservation?.user.fullName}',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                'phone number'.tr,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                // reservation?.user.phoneNumber ?? "",
                                (currentUser?.userName
                                            .contains("defaultCustomer") ??
                                        false)
                                    ? '${reservation?.phoneNumber}'
                                    : '${reservation?.user.phoneNumber}',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cabin(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
                conditionalExpansionTile(reservation?.orderDetails.length == 0),
                Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'action'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
                ),
                conditionalActionRow('${reservation?.status}'),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  conditionalButtonOrder(bool check) {
    if (check) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => menuCategory(
                      jwtToken: widget.jwtToken,
                      reservationId:
                          int.parse(reservation?.id.toString() ?? ""),
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          'order food'.tr,
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => menuStatus(
                      jwtToken: widget.jwtToken,
                      reservationId:
                          int.parse(reservation?.id.toString() ?? ""),
                      orderId: currentOrder?.id,
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          'check status'.tr,
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      );
    }
  }

  conditionalButtonDeposit() {
    return ElevatedButton(
      onPressed: () {
        if (currentUser?.userName.contains("defaultCustomer") ?? false) {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'deposit'.tr,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: TextFormField(
                  onChanged: (value) {},
                  controller: depositController,
                  // initialValue: changeFormat(reservation?.prePaid ?? 0),
                  // keyboardType: TextInputType.multiline,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: 'Input money to deposit'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      addBilling(reservation?.id);
                      Navigator.pop(context, 'Cancel');
                      getData();
                    },
                    child: Text('Done'.tr),
                  ),
                ],
              );
            },
          );
        } else {
          // WebView(
          //   initialUrl: payment?.url,
          // );
          launchUrl(
            Uri.parse(payment?.url ?? "NULL URL"),
            mode: LaunchMode.externalApplication,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(
        'deposit'.tr,
        style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
      ),
    );
  }

  conditionalButtonPreOrder() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => menuCategory(
                  jwtToken: widget.jwtToken,
                  orderFood: true,
                  reservationId: widget.id)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(
        'pre-order'.tr,
        style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
      ),
    );
  }

  conditionalButtonCancel() {
    return ElevatedButton(
      onPressed: () {
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
              content: Container(
                height: 150,
                child: Column(
                  children: [
                    Text(
                      'Are you really want to cancel this reservation?'.tr,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        onChanged: (value) {
                          if (cancelController.text.isEmpty) {
                            setState(() {
                              flagCancel = true;
                              errorCancel = 'Please input a reason!'.tr;
                            });
                          } else {
                            setState(() {
                              flagCancel = false;
                              errorCancel = '';
                            });
                          }
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: cancelController,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Cancel Reason'.tr,
                          errorText: flagCancel ? errorCancel.tr : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('no'.tr),
                ),
                TextButton(
                  onPressed: () {
                    if (cancelController.text.isEmpty) {
                      Navigator.pop(context, 'Cancel');
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: Alignment.center,
                            icon: const Icon(Icons.info_outline_rounded),
                            title: Text(
                              'Remind'.tr,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Container(
                              alignment: Alignment.center,
                              height: 70,
                              child: Column(
                                children: [
                                  Text(
                                    'Please input your reason'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      setState(() {
                        Navigator.pop(context, 'Cancel');
                        cancelRes();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  homeScreen(jwtToken: widget.jwtToken)),
                        );
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              alignment: Alignment.center,
                              icon: const Icon(Icons.info_outline_rounded),
                              title: Text(
                                'Remind'.tr,
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                alignment: Alignment.center,
                                height: 70,
                                child: Column(
                                  children: [
                                    Text(
                                      'Your reservation has been cancelled!'.tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Hope we can see each other another day!'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text('yes'.tr),
                )
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Text(
        'Cancel'.tr,
        style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
      ),
    );
  }

  conditionalButtonCheckin(DateTime dateTime) {
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(dateTime.toString().substring(11, 16).split(":")[0]),
        minute: int.parse(dateTime.toString().substring(11, 16).split(":")[1]));

    double nowDouble = toDouble(nowTime);
    double startDouble = toDouble(startTime);
    // startDouble + 0.5;
    // startDouble - 0.5;
    if (nowDouble >= startDouble - 0.25 &&
        (reservation?.status ?? "Reserved").contains("Reserved")) {
      return ElevatedButton(
        onPressed: () async {
          RemoteService().checkinReservation(widget.id, widget.jwtToken);
          reservation = await RemoteService()
              .getReservationBeforeCheckin(widget.id, widget.jwtToken);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => reservationDetail(
                      id: widget.id,
                      jwtToken: widget.jwtToken,
                    )),
          );
          // setState(() {
          //   tableId = reservation?.reservationTables.elementAt(0).tableId;
          // });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          'Check In',
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          'Check In',
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      );
    }
  }

  conditionalExpansionTile(bool flag) {
    if (flag) {
      return Container();
    } else {
      return SingleChildScrollView(
        child: ExpansionTile(
          collapsedIconColor: Colors.red,
          iconColor: Colors.red,
          title: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ((reservation?.status ?? "").contains("Reserved"))
                          ? Colors.yellow[600]
                          : ((reservation?.status ?? "").contains("Available"))
                              ? Colors.blueAccent
                              : Colors.greenAccent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.lunch_dining_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Order Detail'.tr,
                    style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reservation?.orderDetails.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ((reservation?.status ?? "")
                                            .contains("Reserved"))
                                        ? Colors.yellow[600]
                                        : ((reservation?.status ?? "")
                                                .contains("Available"))
                                            ? Colors.blueAccent
                                            : Colors.greenAccent,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${reservation?.orderDetails.elementAt(index).foodName}',
                                      style: GoogleFonts.cabin(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Price'.tr}: ${changeFormat(reservation?.orderDetails.elementAt(index).price ?? 0)} đ',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Amount'.tr}: ${reservation?.orderDetails.elementAt(index).quantity}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${changeFormat(reservation?.orderDetails.elementAt(index).amount ?? 0)} đ',
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
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  conditionalActionRow(String status) {
    if (status.contains("CheckIn")) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          conditionalButtonOrder(flag),
        ],
      );
    } else if (status.contains("Reserved")) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          conditionalButtonCancel(),
          conditionalButtonCheckin(reservation?.startTime ?? DateTime.now()),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          conditionalButtonCancel(),
          conditionalButtonPreOrder(),
          conditionalButtonDeposit(),
        ],
      );
    }
  }
}
