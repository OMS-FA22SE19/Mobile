// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/User%20History/history_page.dart';

import '../Table reservation/table_reservation.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          'Hello! We hope you have a good day!',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                              'Tran Minh Quan',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    'Table Reservation',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => tableReservation()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Menu',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => menuCategory()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'History',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => historyPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            centerTitle: true,
            title: Text('Menu',
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                )),
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
            bottom: const TabBar(
              indicatorColor: Colors.green,
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Recommended",
                  icon: Icon(Icons.restaurant_rounded),
                ),
                Tab(
                  text: "News",
                  icon: Icon(Icons.restaurant_rounded),
                ),
                Tab(text: "Promotions", icon: Icon(Icons.attach_money_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: []),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
