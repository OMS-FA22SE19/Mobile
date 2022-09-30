// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/menu_food_detaiil.dart';
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
        length: 2,
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
                  text: "Reservations",
                  icon: Icon(Icons.table_bar_rounded),
                ),
                Tab(text: "Recommend", icon: Icon(Icons.restaurant_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: TabBarView(
            children: [
              //
              //
              //
              //
              //TAB 1
              SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 180,
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
                                    'YOUR RESERVATION',
                                    maxLines: 2,
                                    style: GoogleFonts.cabin(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'DATE:    22/22/2222',
                                        maxLines: 2,
                                        style: GoogleFonts.cabin(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        'TIME:    22:22',
                                        maxLines: 2,
                                        style: GoogleFonts.cabin(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SEATS:    4 Peoples',
                                        maxLines: 2,
                                        style: GoogleFonts.cabin(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        'TYPE:    Outdoor',
                                        maxLines: 2,
                                        style: GoogleFonts.cabin(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              )),
              //
              //
              //
              //
              //TAB 2
              SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => menuFoodDetail(
                                  name: "asc",
                                  image:
                                      "https://img.freepik.com/premium-photo/big-hamburger-with-double-beef-french-fries_252907-8.jpg?w=2000",
                                )),
                      );
                    },
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Icon(
                            Icons.fastfood_outlined,
                            size: 120,
                            color: Colors.white,
                          ),
                          Text(
                            'Main Course',
                            style: GoogleFonts.cabin(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Rate: 4.5 / 5',
                            style: GoogleFonts.cabin(
                                fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            "Price: \$\$\$\$",
                            style: GoogleFonts.cabin(
                                fontSize: 18, color: Colors.white),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
