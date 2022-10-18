// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Table%20reservation/date_picker.dart';
import 'package:oms_mobile/services/remote_service.dart';

class tableInformation extends StatefulWidget {
  final int numberOfPeople;
  final String name;
  final String phone;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int tableTypeId;
  final int numberOfSeats;
  final int amount;
  const tableInformation(
      {super.key,
      required this.name,
      required this.phone,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.tableTypeId,
      required this.numberOfSeats,
      required this.numberOfPeople,
      required this.amount});

  @override
  State<tableInformation> createState() => _tableInformationState();
}

class _tableInformationState extends State<tableInformation> {
  @override
  void initState() {
    super.initState();
  }

  postData(String start, String end, int numberOfSeats, int numberOfPeople,
      int tableTypeId, bool isPriorFoodOrder, int quantity) async {
    RemoteService().createReservations(start, end, numberOfSeats,
        numberOfPeople, tableTypeId, isPriorFoodOrder, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('Reservation',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => datePicker(
                          amount: widget.amount,
                          numberOfPeople: widget.numberOfPeople,
                          numberOfSeats: widget.numberOfSeats,
                          tableTypeId: widget.tableTypeId,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
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
        ],
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
              color: Color.fromRGBO(232, 192, 125, 100),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.table_restaurant_rounded,
                  size: 150,
                  color: Colors.white,
                ),
                Text('TABLE INFORMATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(50),
                      1: FixedColumnWidth(180),
                      2: FlexColumnWidth(),
                    },
                    children: <TableRow>[
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Number of people:',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.numberOfPeople}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.chair_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Number of seats: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.numberOfSeats}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Date: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.timer_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Start time: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.startTime.format(context)}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.timer_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'End time: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.endTime.format(context)}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'User: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'User Default',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Phone: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '0941767748',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ],
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
                    onPressed: () {
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

                        // if (widget.time.minute.toString().length == 2) {
                        //   startTime =
                        //       '${widget.date.year}-${widget.date.month}-${widget.date.day}T${widget.time.hour}:${widget.time.minute}:00.000Z';
                        // } else {
                        //   startTime =
                        //       '${widget.date.year}-${widget.date.month}-${widget.date.day}T${widget.time.hour}:0${widget.time.minute}:00.000Z';
                        // }

                        // String endHour = (int.parse(startHour) + 1).toString();
                        String start =
                            '${widget.date.year}-$startMonth-$startDay' +
                                'T' +
                                '$startHour:$startMinute:00.000Z';
                        String end =
                            '${widget.date.year}-$startMonth-$startDay' +
                                'T' +
                                '$endHour:$endMinute:00.000Z';

                        // postData(start, end, widget.numberOfSeats,
                        //     widget.tableTypeId, false);

                        postData(
                            start,
                            end,
                            widget.numberOfSeats,
                            widget.numberOfPeople,
                            widget.tableTypeId,
                            false,
                            widget.amount);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                        );
                      });
                    },
                    child: Text(
                      'Confirm'.toUpperCase(),
                      style: TextStyle(
                          color: Color.fromRGBO(232, 192, 125, 100),
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


                // Text(
                //   'Phone: ${widget.phone}',
                //   style: GoogleFonts.roboto(
                //       fontSize: 20,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   'Name: ${widget.name}',
                //   style: GoogleFonts.roboto(
                //       fontSize: 20,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold),
                // ),