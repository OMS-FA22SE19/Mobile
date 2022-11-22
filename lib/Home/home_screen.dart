// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
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
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
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
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.table_restaurant_rounded),
                    label: 'reservation'.tr),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                  label: 'create'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'history'.tr,
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
}
