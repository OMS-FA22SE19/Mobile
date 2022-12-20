// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:get/get.dart';

class tableInformation extends StatefulWidget {
  final String jwtToken;
  final int numberOfPeople;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int tableTypeId;
  final int numberOfSeats;
  final int amount;
  final int deposit;
  final String tableTypeName;
  final String fullName;
  final String phoneNumber;
  const tableInformation(
      {super.key,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.tableTypeId,
      required this.numberOfSeats,
      required this.numberOfPeople,
      required this.amount,
      required this.deposit,
      required this.tableTypeName,
      required this.jwtToken,
      required this.fullName,
      required this.phoneNumber});

  @override
  State<tableInformation> createState() => _tableInformationState();
}

class _tableInformationState extends State<tableInformation> {
  String start = "";
  String end = "";
  bool orderFood = false;
  UserProfile? currentUser;
  ReservationNoTable? currentReservation;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  // postData(String start, String end, int numberOfSeats, int numberOfPeople,
  //     int tableTypeId, bool isPriorFoodOrder, int quantity) async {
  //   ReservationNoTable? returnReserv;
  //   returnReserv = await RemoteService().createReservations(start, end,
  //       numberOfSeats, numberOfPeople, tableTypeId, isPriorFoodOrder, quantity);
  //   return returnId;
  // }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  checkInDefault(int? id) {
    RemoteService().checkInReservationDefault(id, widget.jwtToken);
  }

  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
    setState(() {});
  }

  // getReservation(int? reservationId) async {
  //   currentReservation = await RemoteService()
  //       .getReservationBeforeCheckin(reservationId ?? 0, widget.jwtToken);
  // }

  // addBilling(int? reservationId, int? money) async {
  //   RemoteService()
  //       .addBillingReservation(reservationId, money, widget.jwtToken);
  // }

  // CheckInReservation(int reservationId) {
  //   RemoteService().checkinReservation(reservationId, widget.jwtToken);
  // }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
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
        title: Text('reservation'.tr,
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
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color:
                  (currentUser?.userName.contains("defaultCustomer") ?? false)
                      ? const Color.fromRGBO(232, 192, 125, 100)
                      : Colors.blue[600],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Icon(
                //   Icons.table_restaurant_rounded,
                //   size: 150,
                //   color: Colors.white,
                // ),
                Text('RESERVATION INFO'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'table'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(40),
                          1: FixedColumnWidth(170),
                          2: FlexColumnWidth(),
                        },
                        children: <TableRow>[
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'Number of people'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.numberOfPeople}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.chair_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'Number of seats'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.numberOfSeats}' +
                                  " x " '${widget.amount}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'Type'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.tableTypeName.tr,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'deposit'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${changeFormat(widget.deposit)} đ',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'datetime'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(40),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: <TableRow>[
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'date'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.timer_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'Start Time'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.startTime.format(context)}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.timer_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'End Time'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.endTime.format(context)}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'customer information'.tr,
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(40),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: <TableRow>[
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'full name'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // '${currentUser?.fullName}',
                              widget.fullName,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${'phone number'.tr}:',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // '${currentUser?.phoneNumber}',
                              widget.phoneNumber,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 35),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        String startMinute;
                        String startHour;
                        String endMinute;
                        String endHour;
                        String startDay;
                        String startMonth;

                        if (widget.date.day.toString().length == 2) {
                          startDay = '${widget.date.day}';
                        } else {
                          startDay = '0${widget.date.day}';
                        }
                        if (widget.date.month.toString().length == 2) {
                          startMonth = '${widget.date.month}';
                        } else {
                          startMonth = '0${widget.date.month}';
                        }
                        if (widget.startTime.minute.toString().length == 2) {
                          startMinute = '${widget.startTime.minute}';
                        } else {
                          startMinute = '0${widget.startTime.minute}';
                        }
                        if (widget.startTime.hour.toString().length == 2) {
                          startHour = '${widget.startTime.hour}';
                        } else {
                          startHour = '0${widget.startTime.hour}';
                        }
                        if (widget.endTime.minute.toString().length == 2) {
                          endMinute = '${widget.endTime.minute}';
                        } else {
                          endMinute = '0${widget.endTime.minute}';
                        }
                        if (widget.endTime.hour.toString().length == 2) {
                          endHour = '${widget.endTime.hour}';
                        } else {
                          endHour = '0${widget.endTime.hour}';
                        }
                        start = '${widget.date.year}-$startMonth-$startDay' +
                            'T' +
                            '$startHour:$startMinute:00.000Z';
                        end = '${widget.date.year}-$startMonth-$startDay' +
                            'T' +
                            '$endHour:$endMinute:00.000Z';
                      });
                      int? returnReservId;
                      returnReservId = await RemoteService().createReservation(
                          start,
                          end,
                          widget.numberOfSeats,
                          widget.numberOfPeople,
                          widget.tableTypeId,
                          widget.amount,
                          widget.fullName,
                          widget.phoneNumber,
                          widget.jwtToken);
                      TimeOfDay nowTime = TimeOfDay.now();
                      double nowTimeDouble = toDouble(nowTime);
                      double startTimeDouble = toDouble(widget.startTime);
                      if (currentUser?.fullName.contains("Default Customer") ??
                          false) {
                        if ((nowTimeDouble >= (startTimeDouble - 0.25)) &&
                            (nowTimeDouble <= startTimeDouble)) {
                          // getReservation(returnReservId);
                          // addBilling(
                          //     returnReservId, currentReservation?.prePaid);
                          // CheckInReservation(returnReservId ?? 0);
                          checkInDefault(returnReservId);
                        }
                      }
                      showDialog(
                        barrierDismissible: true,
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
                              'Do you want to pre-order food with this reservation?'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context, 'Cancel');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => menuCategory(
                                              jwtToken: widget.jwtToken,
                                              orderFood: true,
                                              reservationId:
                                                  returnReservId ?? 0)),
                                    );
                                  });
                                },
                                child: Text('yes'.tr),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context, 'Cancel');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => homeScreen(
                                                jwtToken: widget.jwtToken,
                                              )),
                                    );
                                  });
                                },
                                child: Text('no'.tr),
                              ),
                            ],
                          );
                        },
                      );
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
                              height: 120,
                              child: Column(
                                children: [
                                  Text(
                                    'You need to pay for your reservation 15 minutes after making a reservation or your reservation will be cancel!'
                                        .tr
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Pre-order food will be include in this reservation'
                                        .tr
                                        .tr,
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
                                },
                                child: Text('I understand'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Finish'.tr.toUpperCase(),
                      style: TextStyle(
                          color: (currentUser?.userName
                                      .contains("defaultCustomer") ??
                                  false)
                              ? const Color.fromRGBO(232, 192, 125, 100)
                              : Colors.blue[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
