// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/services/remote_service.dart';

class tableInformation extends StatefulWidget {
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
      required this.numberOfSeats});

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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                  'Below is your table information, please check agan before confirm!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('After your confirmation, we will reach out to you soon.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
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
              Text(
                'Table type: ${widget.tableTypeId}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Date: ${widget.date.day}/${widget.date.month}/${widget.date.year}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Time: ${widget.time.hour}:${widget.time.minute}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Phone: ${widget.phone}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Name: ${widget.name}',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
                      String end = '${widget.date.year}-$startMonth-$startDay' +
                          'T' +
                          '$endHour:$startMinute:00.000Z';

                      postData(start, end, widget.numberOfSeats,
                          widget.tableTypeId, false);
                    });
                  },
                  child: Text(
                    'Confirm'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.greenAccent,
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
        )),
      )),
    );
  }
}
