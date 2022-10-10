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
  final TimeOfDay time;
  final int tableTypeId;
  final int numberOfSeats;
  const tableInformation(
      {super.key,
      required this.name,
      required this.phone,
      required this.date,
      required this.time,
      required this.tableTypeId,
      required this.numberOfSeats,
      required this.numberOfPeople});

  @override
  State<tableInformation> createState() => _tableInformationState();
}

class _tableInformationState extends State<tableInformation> {
  @override
  void initState() {
    super.initState();
  }

  postData(String start, String end, int numberOfSeats, int tableTypeId,
      bool isPriorFoodOrder) async {
    RemoteService().createReservations(
        start, end, numberOfSeats, tableTypeId, isPriorFoodOrder);
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
                          '${widget.time.format(context)}',
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
                          'Duration: ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '1 Hour',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                      setState(() {
                        String startMinute;
                        String startHour = "0";

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

                        if (widget.time.minute.toString().length == 2) {
                          startMinute = '${widget.time.minute}';
                        } else {
                          startMinute = '0${widget.time.minute}';
                        }

                        if (widget.time.hour.toString().length == 2) {
                          startHour = '${widget.time.hour}';
                        } else {
                          startHour = '0${widget.time.hour}';
                        }

                        // if (widget.time.minute.toString().length == 2) {
                        //   startTime =
                        //       '${widget.date.year}-${widget.date.month}-${widget.date.day}T${widget.time.hour}:${widget.time.minute}:00.000Z';
                        // } else {
                        //   startTime =
                        //       '${widget.date.year}-${widget.date.month}-${widget.date.day}T${widget.time.hour}:0${widget.time.minute}:00.000Z';
                        // }

                        String endHour = (int.parse(startHour) + 1).toString();
                        String start =
                            '${widget.date.year}-$startMonth-$startDay' +
                                'T' +
                                '$startHour:$startMinute:00.000Z';
                        String end =
                            '${widget.date.year}-$startMonth-$startDay' +
                                'T' +
                                '$endHour:$startMinute:00.000Z';

                        postData(start, end, widget.numberOfSeats,
                            widget.tableTypeId, false);
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