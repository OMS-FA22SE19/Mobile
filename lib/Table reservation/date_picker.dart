// ignore_for_file: camel_case_types, prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Models/available_date.dart';
import 'package:oms_mobile/Table%20reservation/table_information.dart';
import 'package:oms_mobile/Table%20reservation/table_picker.dart';
import 'package:oms_mobile/services/remote_service.dart';

class datePicker extends StatefulWidget {
  final int tableTypeId;
  final int numberOfSeats;
  final int numberOfPeople;
  final int amount;
  const datePicker(
      {super.key,
      required this.numberOfSeats,
      required this.tableTypeId,
      required this.numberOfPeople,
      required this.amount});

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
  TimeOfDay _selectedTime = TimeOfDay(hour: 11, minute: 0);
  final TimeOfDay _openTime = TimeOfDay(hour: 11, minute: 0);
  final TimeOfDay _closeTime = TimeOfDay(hour: 22, minute: 0);
  bool ocupiedFlag = false;
  bool invalidFlag = false;
  double chooseTime = 0;
  double openTime = 0;
  double closeTime = 0;
  String errorText = "";
// @override
// String formatTimeOfDay(
// TimeOfDay timeOfDay,
// {bool alwaysUse24HourFormat = false}
// )
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData(today.toString());
  }

  getData(String date) async {
    dates = await RemoteService().getTimeAvailable(
        widget.numberOfSeats, widget.tableTypeId, date.substring(0, 10), 10);
    if (dates != null) {
      setState(() {
        isLoaded = true;
        flag = true;
      });
    }
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Current Choosed Date: ' +
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: GoogleFonts.cabin(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
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
                        style: GoogleFonts.cabin(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Occupied Time: ',
                  style: GoogleFonts.cabin(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
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
                  'Business Hour: ${_openTime.format(context)} - ${_closeTime.format(context)}',
                  // 'Current Choosed Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                  style: GoogleFonts.cabin(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Current Choosed Time: ${_selectedTime.format(context)}',
                  // 'Current Choosed Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                  style: GoogleFonts.cabin(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(232, 192, 125, 100),
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 11, minute: 00),
                        builder: (context, childWidget) {
                          return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                  // Using 24-Hour format
                                  alwaysUse24HourFormat: true),
                              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                              child: childWidget!);
                        });
                    //CANCEL
                    if (newTime == null) return;
                    //OK
                    setState(() {
                      chooseTime = toDouble(newTime);
                      openTime = toDouble(_openTime);
                      closeTime = toDouble(_closeTime);
                      ocupiedFlag = false;
                      invalidFlag = false;
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
                          ocupiedFlag = true;
                          errorText =
                              "The time you choose is already occupied, Please choose again!";
                        }
                      });

                      if (chooseTime < openTime || chooseTime >= closeTime) {
                        invalidFlag = true;
                        if (chooseTime == closeTime) {
                          errorText =
                              "Our restaurant close at 10:00PM. Please choose again!";
                        } else {
                          errorText =
                              "Our bussiness hour is from 11:00AM - 10:00PM. Please choose again!";
                        }
                      }

                      if (ocupiedFlag || invalidFlag) {
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
                                errorText,
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
                        return;
                      } else {
                        _selectedTime = newTime;
                      }
                    });
                  },
                  child: Text(
                    'Open Time Picker',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
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
                      backgroundColor: Color.fromRGBO(232, 192, 125, 100),
                      minimumSize: Size(double.infinity, 35),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onPressed: invalidFlag || ocupiedFlag
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => tableInformation(
                                        tableTypeName: "",
                                        deposit: 100,
                                        amount: widget.amount,
                                        numberOfPeople: widget.numberOfPeople,
                                        name: "Default User",
                                        phone: "0941767748",
                                        date: _selectedDate,
                                        startTime: _selectedTime,
                                        endTime: _selectedTime,
                                        tableTypeId: widget.tableTypeId,
                                        numberOfSeats: widget.numberOfSeats,
                                      )),
                            );
                          },
                    child: Text(
                      'Confirm'.toUpperCase(),
                      style: GoogleFonts.cabin(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
