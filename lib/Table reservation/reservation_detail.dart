// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Models/payment_url.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:url_launcher/url_launcher.dart';

class reservationDetail extends StatefulWidget {
  final int id;
  const reservationDetail({super.key, required this.id});

  @override
  State<reservationDetail> createState() => _reservationDetailState();
}

class _reservationDetailState extends State<reservationDetail> {
  ReservationNoTable? reservation;
  bool isLoaded = false;
  TimeOfDay nowTime = TimeOfDay.now();
  int tableId = 0;
  paymentURL? payment;

  @override
  void initState() {
    super.initState();
    getData();
    getVNPAYurl();
  }

  getData() async {
    reservation = await RemoteService().getReservationBeforeCheckin(widget.id);
    if (reservation != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  getVNPAYurl() async {
    payment = await RemoteService().getPaymentURLReservation(widget.id, 100000);
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('Detail',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const homeScreen()),
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
                        'Remind',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        "You can only checkin before / after 30 minutes of the start time of the reservation",
                        style: GoogleFonts.lato(
                          color: Colors.black,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('I understand'),
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
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Visibility(
          visible: isLoaded,
          child: conditionalWidget(reservation?.status ?? ""),
        ),
      ),
    );
  }

  conditionalWidget(String status) {
    if (status.contains("CheckIn")) {
      return Column(
        children: [
          const Icon(
            Icons.table_restaurant_rounded,
            size: 80,
            color: Colors.black,
          ),
          Text(
            'YOUR RESERVATION',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Reservation information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              // height: 400,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(children: [
                      Text(
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime
                                .toString()
                                .substring(0, 10)
                                .replaceAll('-', '/') ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Start Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime.toString().substring(11, 16) ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'End Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.endTime.toString().substring(11, 16) ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of People:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.numOfPeople.toString() ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of Seats:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${reservation?.numOfSeats.toString()} x ${reservation?.quantity.toString()}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Table type:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.tableType ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'User information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Full Name',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.fullName ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Phone Number',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.phoneNumber ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Table information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Status: ',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.status ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Table Id: ',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.reservationTables
                                .elementAt(0)
                                .tableId
                                .toString() ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => menuCategory(
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
                  'Order Food',
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      );
    } else if ((status.contains("Reserved"))) {
      return Column(
        children: [
          const Icon(
            Icons.table_restaurant_rounded,
            size: 80,
            color: Colors.black,
          ),
          Text(
            'YOUR RESERVATION',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Reservation information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              // height: 400,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(children: [
                      Text(
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime
                                .toString()
                                .substring(0, 10)
                                .replaceAll('-', '/') ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Start Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime.toString().substring(11, 16) ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'End Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.endTime.toString().substring(11, 16) ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of People:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.numOfPeople.toString() ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of Seats:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${reservation?.numOfSeats.toString()} x ${reservation?.quantity.toString()}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Table type:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.tableType ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'User information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Full Name',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.fullName ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Phone Number',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.phoneNumber ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Table information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Status: ',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.status ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  RemoteService().cancelReservation(reservation?.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homeScreen()),
                  );
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(payment?.url ?? "NULL URL"),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  'Deposit',
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              conditionalButtonCheckin(reservation?.startTime ?? DateTime.now())
            ],
          )
        ],
      );
    } else {
      return Column(
        children: [
          const Icon(
            Icons.table_restaurant_rounded,
            size: 80,
            color: Colors.black,
          ),
          Text(
            'YOUR RESERVATION',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Reservation information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              // height: 400,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(children: [
                      Text(
                        'Date:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime
                                .toString()
                                .substring(0, 10)
                                .replaceAll('-', '/') ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Start Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.startTime.toString().substring(11, 16) ??
                            "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'End Time:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.endTime.toString().substring(11, 16) ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of People:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.numOfPeople.toString() ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Number of Seats:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${reservation?.numOfSeats.toString()} x ${reservation?.quantity.toString()}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Table type:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.tableType ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'User information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Full Name',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.fullName ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Phone Number',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.user.phoneNumber ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Table information',
            maxLines: 2,
            style: GoogleFonts.cabin(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(children: [
                      Text(
                        'Status: ',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        reservation?.status ?? "",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  RemoteService().cancelReservation(reservation?.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homeScreen()),
                  );
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(payment?.url ?? "NULL URL"),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  'Deposit',
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              conditionalButtonCheckin(reservation?.startTime ?? DateTime.now())
            ],
          )
        ],
      );
    }
  }

  conditionalButtonCheckin(DateTime dateTime) {
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(dateTime.toString().substring(11, 16).split(":")[0]),
        minute: int.parse(dateTime.toString().substring(11, 16).split(":")[1]));

    double nowDouble = toDouble(nowTime);
    double startDouble = toDouble(startTime);
    // startDouble + 0.5;
    // startDouble - 0.5;
    if (nowDouble >= startDouble - 0.5 &&
        nowDouble <= startDouble + 0.5 &&
        (reservation?.status ?? "Reserved").contains("Reserved")) {
      return ElevatedButton(
        onPressed: () async {
          RemoteService().checkinReservation();
          reservation =
              await RemoteService().getReservationBeforeCheckin(widget.id);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => reservationDetail(id: widget.id)),
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
}
