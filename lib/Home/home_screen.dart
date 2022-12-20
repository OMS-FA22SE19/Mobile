// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:oms_mobile/Models/reservation.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Models/user_profile.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/User%20History/history_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import '../Table reservation/table_reservation.dart';

class homeScreen extends StatefulWidget {
  final String jwtToken;
  const homeScreen({super.key, required this.jwtToken});

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

  UserProfile? currentUser;
  getUser() async {
    currentUser = await RemoteService().getUserProfile(widget.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    getUser();
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
      reservationList(jwtToken: widget.jwtToken),
      tableReservation(jwtToken: widget.jwtToken),
      historyPage(jwtToken: widget.jwtToken),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedFontSize: 15,
                selectedIconTheme: IconThemeData(
                    color: (currentUser?.userName.contains("defaultCustomer") ??
                            false)
                        ? const Color.fromRGBO(232, 192, 125, 100)
                        : Colors.blue[600],
                    size: 30),
                selectedItemColor:
                    (currentUser?.userName.contains("defaultCustomer") ?? false)
                        ? const Color.fromRGBO(232, 192, 125, 100)
                        : Colors.blue[600],
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (currentUser?.userName.contains("defaultCustomer") ??
                          false)
                      ? const Color.fromRGBO(232, 192, 125, 100)
                      : Colors.blue[600],
                ),
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
      ),
    );
  }
}
