// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/available_date.dart';
import 'package:oms_mobile/Table%20reservation/table_picker.dart';
import 'package:oms_mobile/Table%20reservation/table_user.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class datePicker extends StatefulWidget {
  final int tableTypeId;
  final int numberOfSeats;
  const datePicker(
      {super.key, required this.numberOfSeats, required this.tableTypeId});

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  List<availableDate>? dates;
  bool isLoaded = false;
  bool flag = false;
  String selectedDate = "";
  String selectedTime = "";
  DateTime today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _openTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _closeTime = TimeOfDay(hour: 22, minute: 0);

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData(today.toString());
  }

  getData(String date) async {
    dates = await RemoteService().getTimeAvailable(
        widget.numberOfSeats, widget.tableTypeId, date.substring(0, 10));
    if (dates != null) {
      setState(() {
        isLoaded = true;
        flag = true;
      });
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) async {
    setState(() {
      selectedDate = args.value.toString();
    });
  }

  void _onTimeSelectionChanged(String text) {
    setState(() {
      selectedTime = text;
    });
  }

  @override
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
                MaterialPageRoute(
                    builder: (context) => tablePicker(
                          numberOfPeople: 4,
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
      body: Visibility(
        visible: isLoaded,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   color: Colors.grey,
                //   child: SfDateRangePicker(
                //     onSelectionChanged: _onSelectionChanged,
                //     view: DateRangePickerView.month,
                //     selectionMode: DateRangePickerSelectionMode.single,
                //     enablePastDates: false,
                //     selectionColor: Colors.greenAccent,
                //     todayHighlightColor: Colors.greenAccent,
                //     // showActionButtons: true,
                //     monthViewSettings:
                //         DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                //   ),
                // ),
                // Container(
                //   height: 200,
                //   child: CupertinoDatePicker(
                //     mode: CupertinoDatePickerMode.date,
                //     initialDateTime: DateTime(1969, 1, 1),
                //     onDateTimeChanged: (DateTime newDateTime) {
                //       // Do something
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Current Choosed Date: ' +
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: today,
                            firstDate: today,
                            lastDate: today.add(Duration(days: 30)));
                        //CANCEL
                        if (newDate == null) return;
                        //OK
                        setState(() {
                          _selectedDate = newDate;
                        });
                        getData(_selectedDate.toString());
                      },
                      child: Text(
                        'Open calendar',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      onPressed: () async {},
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Occupied Time: ',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: dates?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              dates![index].startTime.substring(11, 16) +
                                  '  -  ' +
                                  dates![index].endTime.substring(11, 16),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Current Choosed Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 00, minute: 00),
                    );
                    //CANCEL
                    if (newTime == null) return;
                    //OK
                    setState(() {
                      dates?.forEach((element) {
                        TimeOfDay _start = TimeOfDay(
                            hour: int.parse(element.startTime
                                .substring(11, 16)
                                .split(":")[0]),
                            minute: int.parse(element.startTime
                                .substring(11, 16)
                                .split(":")[1]));
                        TimeOfDay _end = TimeOfDay(
                            hour: int.parse(element.endTime
                                .substring(11, 16)
                                .split(":")[0]),
                            minute: int.parse(element.endTime
                                .substring(11, 16)
                                .split(":")[1]));

                        if (_selectedTime.hour >= _start.hour &&
                            _selectedTime.hour <= _end.hour) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Invalid Time',
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'The time you choose is already occupied, Please choose again!',
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('I understand'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (_selectedTime.hour < _openTime.hour ||
                            _selectedTime.hour > _closeTime.hour) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Invalid Time',
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'The time you choose is not in bussiness hour, Please choose again!',
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('I understand'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {}
                      });
                      _selectedTime = newTime;
                    });
                  },
                  child: Text(
                    'Open Time Picker',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 25,
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
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  tableTypeId: widget.tableTypeId,
                                  numberOfSeats: widget.numberOfSeats,
                                )),
                      );
                    },
                    child: Text(
                      'Confirm'.toUpperCase(),
                      style: GoogleFonts.bebasNeue(
                          color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
