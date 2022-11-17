// ignore_for_file: prefer_const_constructors, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/available_date.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Models/table.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Table%20reservation/table_information_edit.dart';
import 'package:oms_mobile/services/remote_service.dart';

class tableReservationEdit extends StatefulWidget {
  final int? reservationId;
  const tableReservationEdit({super.key, this.reservationId});

  @override
  State<tableReservationEdit> createState() => _tableReservationEditState();
}

class _tableReservationEditState extends State<tableReservationEdit> {
  final inputController = TextEditingController(text: "2");
  List<tableAvailable>? tables;
  List<availableDate>? dates;
  ReservationNoTable? currentReservation;
  bool checkflag = false;
  int checkId = -1;

  bool chooseFlag = false;
  int chooseIndex = -1;
  bool flag = true;
  bool flagText = false;
  bool hiddenFlag = true;
  bool isLoaded = false;
  bool isLoadedTime = false;
  int numberOfPeople = 0;
  int numberOfSeats = 0;
  int tableTypeId = 0;
  int quantity = 0;
  int deposit = 0;
  int overcharged = 0;
  String tableTypeName = "";
  Color onSelected = Color.fromRGBO(232, 192, 125, 50);

  String selectedDate = "";
  String selectedTime = "";
  DateTime today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay(hour: 11, minute: 0);
  TimeOfDay _selectedEndTime = TimeOfDay(hour: 12, minute: 0);
  final TimeOfDay _openTime = TimeOfDay(hour: 11, minute: 0);
  final TimeOfDay _closeTime = TimeOfDay(hour: 22, minute: 0);
  bool ocupiedFlag = true;
  bool invalidFlag = true;
  double chooseTime = 0;
  double openTime = 0;
  double closeTime = 0;
  String errorText = "";
  int settingHour = 3;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData(2);
  }

  getData(int people) async {
    tables = await RemoteService().getTablesAvailable(people);
    currentReservation = await RemoteService()
        .getReservationBeforeCheckin(widget.reservationId ?? 0);
    int? check = tables?.length;
    if (tables != null) {
      setState(() {
        isLoaded = true;
      });
    }
    if (check == 0) {
      setState(() {
        isLoaded = false;
      });
    }
    // if (currentReservation != null) {
    //   List<tableAvailable>? checkTables = await RemoteService()
    //       .getTablesAvailable(currentReservation?.numOfPeople ?? 0);
    //   checkTables?.forEach((element) {
    //     print(
    //         '${element.tableTypeName} + ${element.numOfSeats} + ${element.quantity} + ${element.tableTypeId}');
    //     print(
    //         '${currentReservation?.tableType} + ${currentReservation?.numOfSeats} + ${currentReservation?.quantity} + ${currentReservation?.tableTypeId} + ${currentReservation?.numOfPeople}');
    //     int count = 0;
    //     if (currentReservation?.numOfSeats == element.numOfSeats) {
    //       if (currentReservation?.quantity == element.quantity) {
    //         if (currentReservation?.tableTypeId == element.tableTypeId) {
    //           if (currentReservation?.tableType == element.tableTypeName) {
    //             setState(() {
    //               checkflag = false;
    //               checkId = count;
    //               print(count);
    //             });
    //           } else {
    //             setState(() {
    //               print("a");
    //               count += 1;
    //             });
    //           }
    //         } else {
    //           setState(() {
    //             print("a");
    //             count += 1;
    //           });
    //         }
    //       } else {
    //         setState(() {
    //           print("a");
    //           count += 1;
    //         });
    //       }
    //     } else {
    //       setState(() {
    //         print("a");
    //         count += 1;
    //       });
    //     }
    //     print(checkId);
    //   });
    // }
  }

  // getReservation() async {
  //   if (widget.reservationId != null) {
  //     reservation = await RemoteService()
  //         .getReservationBeforeCheckin(widget.reservationId ?? 0);
  //   }
  // }

  getdab() {
    DateTime date2 = DateFormat("hh:mma").parse("6:45PM");
  }

  getTimeAvailable(String date) async {
    dates = await RemoteService().getTimeAvailable(
        numberOfSeats, tableTypeId, date.substring(0, 10), quantity);
    int? check = dates?.length;
    if (dates != null) {
      setState(() {
        isLoadedTime = true;
      });
    }
    if (check == 0) {
      setState(() {
        isLoadedTime = false;
      });
    }
  }

  // getChargePerSeat(int typeId) async {
  //   int charge = await RemoteService().getTableChargePerSeat(tableTypeId);
  //   return int;
  // }

  getTableType(int typeId) async {
    int charge = await RemoteService().getTableChargePerSeat(tableTypeId);
    deposit = charge * numberOfSeats * quantity;
    overcharged = (deposit - (currentReservation?.prePaid ?? 0));
    tableTypeName = await RemoteService().getTableTypeName(tableTypeId);
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      icon: Icon(Icons.info_outline_rounded),
                      title: Text(
                        'Remind',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Container(
                        height: 100,
                        child: Column(
                          children: [
                            Text(
                              "Please remember, any overcharged money won't be refund!"
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "If you choose a different table type, table information might be changed",
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
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('I understand'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          reservationBox(currentReservation),
          SizedBox(
            height: 10,
          ),
          Text(
            'Guest Amount: ',
            style: GoogleFonts.cabin(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    if (inputController.text.isEmpty) {
                      setState(() {
                        flagText = true;
                        flag = true;
                        hiddenFlag = true;
                        getData(1000);
                        chooseIndex = 10000;
                      });
                    } else {
                      setState(() {
                        flagText = false;
                        flag = false;
                        getData(int.parse(inputController.text));
                      });
                    }
                  },
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Input number of guest',
                    // labelText: 'Input number of guest',
                    errorText: flagText ? 'Please input a number!' : null,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            style: GoogleFonts.cabin(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(232, 192, 125, 100),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
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
                getTimeAvailable(_selectedDate.toString());
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
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isLoaded,
            replacement: Center(),
            child: Container(
              height: 180,
              child: ListView.builder(
                itemCount: tables?.length,
                physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    canRequestFocus: false,
                    onTap: () {
                      setState(() {
                        numberOfSeats = tables![index].numOfSeats;
                        quantity = tables![index].quantity;
                        tableTypeId = tables![index].tableTypeId;
                        hiddenFlag = false;
                      });
                      getTimeAvailable(_selectedDate.toString());
                      getTableType(tableTypeId);
                      chooseFlag = true;
                      chooseIndex = index;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Container(
                        height: 120,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: chooseIndex == index
                              ? Colors.green
                              : Color.fromRGBO(232, 192, 125, 50),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.table_bar_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tables![index].tableTypeName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Number of seats: ${tables![index].numOfSeats.toString()}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'Amount: ${tables![index].quantity.toString()}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          conditionalWidget(hiddenFlag),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  conditionalWidget(bool check) {
    if (check) {
      return Container();
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 192, 125, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'Deposit: ${changeFormat(deposit)} đ',
                    textAlign: TextAlign.center,
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
                    'Overcharged: ${changeFormat(overcharged <= 0 ? 0 : (deposit - (currentReservation?.paid ?? 0)))} đ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            isLoadedTime ? 'Occupied Time: ' : "",
            textAlign: TextAlign.center,
            style: GoogleFonts.cabin(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isLoadedTime,
            replacement: Center(),
            child: Container(
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
                          '${dates![index].startTime.substring(11, 16)}  -  ${dates![index].endTime.substring(11, 16)}',
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
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Selection Start Time:',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _selectedStartTime.format(context),
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(232, 192, 125, 100),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 11, minute: 00),
                        builder: (context, childWidget) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
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

                        double _ocupiedStart = toDouble(_start);
                        double _ocupiedEnd = toDouble(_end);

                        if (chooseTime >= _ocupiedStart &&
                            chooseTime < _ocupiedEnd) {
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
                      // else {
                      //   if (chooseTime >= toDouble(_selectedEndTime)) {
                      //     invalidFlag = true;
                      //     errorText =
                      //         "Start time must not greater than End time. Please choose again!";
                      //   }
                      // }

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
                        _selectedStartTime = newTime;
                      }
                    });
                  },
                  child: Text(
                    'Time Picker',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Selection End Time:',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _selectedEndTime.format(context),
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(232, 192, 125, 100),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 11, minute: 00),
                        builder: (context, childWidget) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
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

                        double _ocupiedStart = toDouble(_start);
                        double _ocupiedEnd = toDouble(_end);

                        if (chooseTime >= _ocupiedStart &&
                            chooseTime <= _ocupiedEnd) {
                          ocupiedFlag = true;
                          errorText =
                              "The time you choose is already occupied, Please choose again!";
                        }
                      });

                      if (chooseTime <= openTime || chooseTime > closeTime) {
                        invalidFlag = true;
                        if (chooseTime == openTime) {
                          errorText =
                              "Our restaurant open at 11:00AM. Please choose again!";
                        } else {
                          errorText =
                              "Our bussiness hour is from 11:00AM - 10:00PM. Please choose again!";
                        }
                      } else {
                        if (chooseTime >= toDouble(_selectedStartTime) &&
                            chooseTime < toDouble(_selectedStartTime) + 0.5) {
                          invalidFlag = true;
                          errorText =
                              "Reservation duration must be at least 30 minutes. Please choose again!";
                        } else if (chooseTime >
                            toDouble(_selectedStartTime) + settingHour) {
                          invalidFlag = true;
                          errorText =
                              'Reservation duration must not longer than $settingHour hours. Please choose again!';
                        } else if (chooseTime < toDouble(_selectedStartTime)) {
                          invalidFlag = true;
                          errorText =
                              "End time must not smaller than Start time. Please choose again!";
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
                        _selectedEndTime = newTime;
                      }
                    });
                  },
                  child: Text(
                    'Time Picker',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          conditionalButtonFinish(),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }
  }

  conditionalButtonFinish() {
    if (ocupiedFlag || invalidFlag) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                        builder: (context) => tableInformationEdit(
                              currentReservation: currentReservation,
                              overcharged: overcharged,
                              tableTypeName: tableTypeName,
                              deposit: deposit,
                              amount: quantity,
                              numberOfPeople: int.parse(inputController.text),
                              name: "Default User",
                              phone: "0941767748",
                              date: _selectedDate,
                              startTime: _selectedStartTime,
                              endTime: _selectedEndTime,
                              tableTypeId: tableTypeId,
                              numberOfSeats: numberOfSeats,
                            )),
                  );
                },
          child: Text(
            'Finish'.toUpperCase(),
            style: GoogleFonts.cabin(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }

  reservationBox(ReservationNoTable? currentReservation) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: (currentReservation?.status.contains('Available') ?? false)
              ? Colors.blueAccent
              : Colors.yellow[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CURRENT INFORMATION',
                  maxLines: 2,
                  style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Table(
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
                        '${currentReservation?.startTime.day.toString()} / ${currentReservation?.startTime.month.toString()} / ${currentReservation?.startTime.year.toString()}',
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
                        '${currentReservation?.startTime.toString().substring(11, 16)}',
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
                        '${currentReservation?.endTime.toString().substring(11, 16)}',
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
                        '${currentReservation?.numOfPeople}',
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
                        '${currentReservation?.quantity} x ${currentReservation?.numOfSeats}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Type:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${currentReservation?.tableType}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Deposit:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${changeFormat(currentReservation?.prePaid ?? 0)} đ',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Paid:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${changeFormat(currentReservation?.paid ?? 0)} đ',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        'Status:',
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        '${currentReservation?.status}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cabin(
                            fontSize: 20, color: Colors.white),
                      ),
                    ]),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
