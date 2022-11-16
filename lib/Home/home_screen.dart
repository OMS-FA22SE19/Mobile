// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import '../Table reservation/table_reservation.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isLoaded = false;
  int _selectedIndex = 0;

  List<ReservationNoTable>? reservationsReserved;
  List<ReservationNoTable>? reservationsCheckIn;
  List<ReservationNoTable>? reservationsAvailable;
  bool isLoaded_1 = false;
  bool isLoaded_2 = false;
  bool isLoaded_3 = false;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    getCheckin();
    getReserved();
    getAvailable();
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  getCheckin() async {
    reservationsCheckIn =
        await RemoteService().getReservationsBeforeCheckin("CheckIn");
    if (reservationsCheckIn != null) {
      if (mounted) {
        setState(() {
          isLoaded_1 = true;
        });
      }
    }
  }

  getReserved() async {
    reservationsReserved =
        await RemoteService().getReservationsBeforeCheckin("Reserved");
    if (reservationsReserved != null) {
      if (mounted) {
        setState(() {
          isLoaded_2 = true;
        });
      }
    }
  }

  getAvailable() async {
    reservationsAvailable =
        await RemoteService().getReservationsBeforeCheckin("Available");
    if (reservationsAvailable != null) {
      if (mounted) {
        setState(() {
          isLoaded_3 = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      reservationList(),
      tableReservation(),
      historyPage(),
    ];

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedFontSize: 15,
              selectedIconTheme: IconThemeData(
                  color: Color.fromRGBO(232, 192, 125, 100), size: 30),
              selectedItemColor: Color.fromRGBO(232, 192, 125, 100),
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.table_restaurant_rounded),
                    label: 'Reservation'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'History',
                ),
              ],
              currentIndex: _selectedIndex, //New
              onTap: _onItemTapped,
            ),
            backgroundColor: Colors.grey[200],
            body: Container(
              child: _pages.elementAt(_selectedIndex),
            )),
      ),
    );
  }

  ReservationCheckIn(String status, int index) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.table_restaurant_rounded,
                size: 80,
                color: Colors.white,
              ),
              Text(
                'RESERVATION INFORMATION',
                maxLines: 2,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(children: [
                    Text(
                      'Date:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index].startTime.day.toString() +
                          "/" +
                          reservationsCheckIn![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsCheckIn![index].startTime.year.toString(),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Start Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index]
                          .startTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'End Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index]
                          .endTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Status:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsCheckIn![index].status,
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                ],
              ),
            ]),
      ),
    );
  }

  ReservationReserved(String status, int index) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.yellow[600],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.table_restaurant_rounded,
                size: 80,
                color: Colors.white,
              ),
              Text(
                'RESERVATION INFORMATION',
                maxLines: 2,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(children: [
                    Text(
                      'Date:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsReserved![index].startTime.day.toString() +
                          "/" +
                          reservationsReserved![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsReserved![index]
                              .startTime
                              .year
                              .toString(),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Start Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsReserved![index]
                          .startTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'End Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsReserved![index]
                          .endTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Status:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsReserved![index].status,
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                ],
              ),
            ]),
      ),
    );
  }

  ReservationAvailable(String status, int index) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.table_restaurant_rounded,
                size: 80,
                color: Colors.white,
              ),
              Text(
                'RESERVATION INFORMATION',
                maxLines: 2,
                style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                  1: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(children: [
                    Text(
                      'Date:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsAvailable![index].startTime.day.toString() +
                          "/" +
                          reservationsAvailable![index]
                              .startTime
                              .month
                              .toString() +
                          "/" +
                          reservationsAvailable![index]
                              .startTime
                              .year
                              .toString(),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Start Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsAvailable![index]
                          .startTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'End Time:',
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      reservationsAvailable![index]
                          .endTime
                          .toString()
                          .substring(11, 16),
                      textAlign: TextAlign.right,
                      style:
                          GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                    ),
                  ]),
                ],
              ),
            ]),
      ),
    );
  }
}
