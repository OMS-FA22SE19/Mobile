// ignore_for_file: prefer_const_constructors, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/admin_settings.dart';
import 'package:oms_mobile/Models/available_date.dart';
import 'package:oms_mobile/Models/table.dart';
import 'package:intl/intl.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/table_information.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:get/get.dart';

class tableReservation extends StatefulWidget {
  final String jwtToken;
  const tableReservation({super.key, required this.jwtToken});

  @override
  State<tableReservation> createState() => _tableReservationState();
}

class _tableReservationState extends State<tableReservation> {
  final inputController = TextEditingController(text: "2");
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  List<tableAvailable>? tables;
  List<availableDate>? dates;
  List<adminSettings>? admin_settings;
  UserProfile? currentUser;
  bool chooseFlag = false;
  int chooseIndex =
      -1; //TODO: 1000 is not valid when too many table on the list
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
  int minDuration = 30;
  int maxDuration = 180;
  int seperateAtLeast = 30;
  String tableTypeName = "";
  Color onSelected = Color.fromRGBO(232, 192, 125, 50);

  String selectedDate = "";
  String selectedTime = "";
  DateTime today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay(hour: 11, minute: 0);
  TimeOfDay _selectedEndTime = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _openTime = TimeOfDay(hour: 11, minute: 0);
  TimeOfDay _closeTime = TimeOfDay(hour: 22, minute: 0);
  bool ocupiedFlag = true;
  bool invalidFlag = true;
  double chooseTime = 0;
  double openTime = 0;
  double closeTime = 0;
  String errorText = "";

  bool flagPhone = false;
  bool flagName = false;
  String nameText = "";
  String phoneText = "";

  // @override
  // void dispose() {
  //   inputController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getUser();
    getData(2);
    getSettings();
  }

  getData(int people) async {
    tables = await RemoteService().getTablesAvailable(people, widget.jwtToken);
    getSettings();
    getUser();
    if (mounted) {
      setState(() {
        nameController.text = '${currentUser?.fullName}';
        phoneController.text = '${currentUser?.phoneNumber}';
      });
    }
    int? check = tables?.length;
    bool? checkb = tables?.isEmpty;
    if (tables != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
    if (check == 0) {
      if (mounted) {
        setState(() {
          isLoaded = false;
        });
      }
    }
  }

  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
    if (mounted) {
      setState(() {
        nameController.text = '${currentUser?.fullName}';
        phoneController.text = '${currentUser?.phoneNumber}';
      });
    }
  }

  getdab() {
    DateTime date2 = DateFormat("hh:mma").parse("6:45PM");
  }

  getTimeAvailableMethod(String date) async {
    dates = await RemoteService().getTimeAvailable(numberOfSeats, tableTypeId,
        date.substring(0, 10), quantity, widget.jwtToken);
    int? check = dates?.length;
    bool? checkb = dates?.isEmpty;
    if (dates != null) {
      if (mounted) {
        setState(() {
          isLoadedTime = true;
        });
      }
    }
    if (check == 0) {
      if (mounted) {
        setState(() {
          isLoadedTime = false;
        });
      }
    }
  }

  getTableType(int typeId) async {
    int charge = await RemoteService()
        .getTableChargePerSeat(tableTypeId, widget.jwtToken);
    deposit = charge * numberOfSeats * quantity;
    tableTypeName =
        await RemoteService().getTableTypeName(tableTypeId, widget.jwtToken);
  }

  getSettings() async {
    admin_settings = await RemoteService().getSettings(widget.jwtToken);
    int endHour = 0;
    int startHour = 0;
    int endMinute = 0;
    int startMinute = 0;
    admin_settings?.forEach((element) {
      if (element.name.contains("StartTime")) {
        if (mounted) {
          setState(() {
            startHour = int.parse(element.value.substring(0, 2));
            startMinute = int.parse(element.value.substring(4, 5));
            _openTime = TimeOfDay(hour: startHour, minute: startMinute);
          });
        }
      }
      if (element.name.contains("EndTime")) {
        if (mounted) {
          setState(() {
            endHour = int.parse(element.value.substring(0, 2));
            endMinute = int.parse(element.value.substring(4, 5));
            _closeTime = TimeOfDay(hour: endHour, minute: endMinute);
          });
        }
      }
      if (element.name.contains("MaxReservationDuration")) {
        if (mounted) {
          setState(() {
            maxDuration = int.parse(element.value);
          });
        }
      }
      if (element.name.contains("MinReservationDuration")) {
        if (mounted) {
          setState(() {
            minDuration = int.parse(element.value);
          });
        }
      }
      if (element.name.contains("AtLeastDuration")) {
        if (mounted) {
          setState(() {
            seperateAtLeast = int.parse(element.value);
          });
        }
      }
    });
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                          'Remind'.tr,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Container(
                          height: 50,
                          child: Column(
                            children: [
                              Text(
                                '${'Business Hours'.tr}:',
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${_openTime.toString().substring(10, 15)}  -  ${_closeTime.toString().substring(10, 15)}',
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
                            child: Text('I understand'.tr),
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
            SizedBox(
              height: 10,
            ),
            Text(
              '${'Guest Amount'.tr}:',
              style: GoogleFonts.cabin(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
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
                          getSettings();
                        });
                      } else {
                        setState(() {
                          flagText = false;
                          flag = false;
                          getData(int.parse(inputController.text));
                          getSettings();
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
                      hintText: 'Input number of guest'.tr,
                      // labelText: 'Input number of guest',
                      errorText: flagText ? 'Please input a number!'.tr : null,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              '${'Selected Date'.tr}: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
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
                  backgroundColor:
                      (currentUser?.userName.contains("defaultCustomer") ??
                              false)
                          ? const Color.fromRGBO(232, 192, 125, 100)
                          : Colors.blue[600],
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
                    getSettings();
                  });
                  getTimeAvailableMethod(_selectedDate.toString());
                },
                child: Text(
                  'Open calendar'.tr,
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
                          getSettings();
                          numberOfSeats = tables![index].numOfSeats;
                          quantity = tables![index].quantity;
                          tableTypeId = tables![index].tableTypeId;
                          hiddenFlag = false;
                        });
                        getTimeAvailableMethod(_selectedDate.toString());
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
                            color: (chooseIndex == index &&
                                    (currentUser?.userName
                                            .contains("defaultCustomer") ??
                                        false))
                                ? Color.fromARGB(156, 255, 162, 0)
                                : (chooseIndex == index &&
                                        !(currentUser?.userName
                                                .contains("defaultCustomer") ??
                                            false))
                                    ? Colors.indigo[900]
                                    : (currentUser?.userName
                                                .contains("defaultCustomer") ??
                                            false)
                                        ? const Color.fromRGBO(
                                            232, 192, 125, 100)
                                        : Colors.blue[600],
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
                                        '${'Number of seats'.tr}: ${tables![index].numOfSeats}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.cabin(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        '${'Amount'.tr}: ${tables![index].quantity}',
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
            ConditionalWidget(hiddenFlag),
          ],
        ),
      ),
    );
  }

  ConditionalWidget(bool check) {
    if (check) {
      return Container();
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            isLoadedTime
                ? '${'Occupied Time'.tr}:'
                : 'This table have no occupied reservation!'.tr,
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
                    '${'Selection Start Time'.tr}:',
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
                    backgroundColor:
                        (currentUser?.userName.contains("defaultCustomer") ??
                                false)
                            ? const Color.fromRGBO(232, 192, 125, 100)
                            : Colors.blue[600],
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
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: childWidget!);
                        });
                    //CANCEL
                    if (newTime == null) return;
                    //OK
                    setState(() {
                      getSettings();
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
                              'The time you choose is already occupied, Please choose again!'
                                  .tr;
                        }
                      });

                      if (chooseTime < openTime || chooseTime >= closeTime) {
                        invalidFlag = true;
                        if (chooseTime == closeTime) {
                          errorText =
                              '${'Our restaurant close at'.tr} ${_closeTime.toString().substring(10, 15)}. ${'Please choose again!'.tr}';
                        } else {
                          errorText =
                              '${'Our bussiness hour is from'.tr} ${_openTime.toString().substring(10, 15)} - ${_closeTime.toString().substring(10, 15)}. ${'Please choose again!'.tr}';
                        }
                      } else {
                        if (currentUser?.userName.contains("defaultCustomer") ??
                            true) {
                        } else {
                          if (chooseTime <
                              (toDouble(TimeOfDay.now()) +
                                  seperateAtLeast / 60)) {
                            invalidFlag = true;
                            errorText =
                                'Start time must be greater than time at the moment $seperateAtLeast minutes!'
                                    .tr;
                          }
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
                                'Invalid Time'.tr,
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
                                  child: Text('I understand'.tr),
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
                    'Time Picker'.tr,
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
                    '${'Selection End Time'.tr}:',
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
                    backgroundColor:
                        (currentUser?.userName.contains("defaultCustomer") ??
                                false)
                            ? const Color.fromRGBO(232, 192, 125, 100)
                            : Colors.blue[600],
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
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: childWidget!);
                        });
                    //CANCEL
                    if (newTime == null) return;
                    //OK
                    setState(() {
                      getSettings();
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
                              'The time you choose is already occupied, Please choose again!'
                                  .tr;
                        }
                      });

                      if (chooseTime <= openTime || chooseTime > closeTime) {
                        invalidFlag = true;
                        if (chooseTime == openTime) {
                          errorText =
                              '${'Our restaurant open at'.tr} ${_openTime.toString().substring(10, 15)}. ${'Please choose again!'.tr}';
                        } else {
                          errorText =
                              '${'Our bussiness hour is from'.tr} ${_openTime.toString().substring(10, 15)} - ${_closeTime.toString().substring(10, 15)}. ${'Please choose again!'.tr}';
                        }
                      } else {
                        if (chooseTime >= toDouble(_selectedStartTime) &&
                            chooseTime <
                                toDouble(_selectedStartTime) +
                                    minDuration / 60) {
                          invalidFlag = true;
                          errorText =
                              'Reservation duration must be at least $minDuration minutes. Please choose again!'
                                  .tr;
                        } else if (chooseTime >
                            toDouble(_selectedStartTime) + maxDuration / 60) {
                          invalidFlag = true;
                          errorText =
                              'Reservation duration must not longer than $maxDuration minutes. Please choose again!'
                                  .tr;
                        } else if (chooseTime < toDouble(_selectedStartTime)) {
                          invalidFlag = true;
                          errorText =
                              'End time must not smaller than Start time. Please choose again!'
                                  .tr;
                        }
                      }

                      if (ocupiedFlag || invalidFlag) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Invalid Time'.tr,
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
                                  child: Text('I understand'.tr),
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
                    'Time Picker'.tr,
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
            height: 20,
          ),
          conditionalInput(),
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

  conditionalInput() {
    if (currentUser?.userName.contains("defaultCustomer") ?? true) {
      return Column(
        children: [
          Text(
            'Input customer information'.tr,
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
          Text(
            '${'full name'.tr}:',
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
                    if (nameController.text.isEmpty) {
                      setState(() {
                        flagName = true;
                        nameText = 'Please input a name!'.tr;
                        getSettings();
                      });
                    } else {
                      setState(() {
                        flagName = false;
                        nameText = "";
                        getSettings();
                      });
                    }
                  },
                  // initialValue: '${currentUser?.fullName}',
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Input fullname'.tr,
                    // labelText: 'Input number of guest',
                    errorText: flagName ? nameText.tr : null,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${'phone number'.tr}:',
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
                    if (phoneController.text.isEmpty) {
                      setState(() {
                        flagPhone = true;
                        phoneText = 'Please input a number!'.tr;
                        getSettings();
                      });
                    } else if (phoneController.text.length < 10) {
                      setState(() {
                        flagPhone = true;
                        phoneText = 'Phone number is not long enough!'.tr;
                        getSettings();
                      });
                    } else if (phoneController.text.length > 10) {
                      setState(() {
                        flagPhone = true;
                        phoneText = 'Phone number is too long!'.tr;
                        getSettings();
                      });
                    } else {
                      setState(() {
                        flagPhone = false;
                        phoneText = "";
                        getSettings();
                      });
                    }
                  },
                  // initialValue: '${currentUser?.phoneNumber}',
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Input your phone number'.tr,
                    // labelText: 'Input number of guest',
                    errorText: flagPhone ? phoneText.tr : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  conditionalButtonFinish() {
    if (ocupiedFlag || invalidFlag || flagPhone || flagName) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                (currentUser?.userName.contains("defaultCustomer") ?? false)
                    ? const Color.fromRGBO(232, 192, 125, 100)
                    : Colors.blue[600],
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
                              fullName: (currentUser?.userName
                                          .contains("defaultCustomer") ??
                                      false)
                                  ? nameController.text
                                  : '${currentUser?.fullName}',
                              phoneNumber: (currentUser?.userName
                                          .contains("defaultCustomer") ??
                                      false)
                                  ? phoneController.text
                                  : '${currentUser?.phoneNumber}',
                              jwtToken: widget.jwtToken,
                              tableTypeName: tableTypeName,
                              deposit: deposit,
                              amount: quantity,
                              numberOfPeople: int.parse(inputController.text),
                              date: _selectedDate,
                              startTime: _selectedStartTime,
                              endTime: _selectedEndTime,
                              tableTypeId: tableTypeId,
                              numberOfSeats: numberOfSeats,
                            )),
                  );
                },
          child: Text(
            'Finish'.tr.toUpperCase(),
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

  conditionalTable(bool flag, int index) {
    if (flag) {
      return Container(
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.greenAccent,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  '${'Number of Seats'.tr}: ${tables![index].numOfSeats}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '${'Amount'.tr}: ${tables![index].quantity}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ]),
      );
    } else {
      return Container(
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(232, 192, 125, 50),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  '${'Number of Seats'.tr}: ${tables![index].numOfSeats}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(fontSize: 18, color: Colors.white),
                ),
                Text(
                  '${'Amount'.tr}: ${tables![index].quantity}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ]),
      );
    }
  }
}
