// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Table%20reservation/table_picker.dart';
import 'package:oms_mobile/Table%20reservation/table_user.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class datePicker extends StatefulWidget {
  const datePicker({super.key});

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  String selectedDate = "";
  String selectedTime = "";

  @override
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value.toString();
    });
  }

  void _onTimeSelectionChanged(String text) {
    setState(() {
      selectedTime = text;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text('Menu',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tablePicker()),
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.single,
            enablePastDates: false,
            selectionColor: Colors.greenAccent,
            todayHighlightColor: Colors.greenAccent,
            // showActionButtons: true,
            monthViewSettings:
                DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  _onTimeSelectionChanged("11:00");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '11:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _onTimeSelectionChanged("13:00");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '13:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _onTimeSelectionChanged("13:00");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '14:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: Size(double.infinity, 35),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => tableUser(
                            date: selectedDate,
                            time: selectedTime,
                          )),
                );
              },
              child: Text(
                'Confirm'.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
