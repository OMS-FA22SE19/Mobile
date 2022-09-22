// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_cart.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';
import 'package:oms_mobile/Menu%20Order/menu_status.dart';
import 'package:badges/badges.dart';

class menuCategory extends StatefulWidget {
  const menuCategory({super.key});

  @override
  State<menuCategory> createState() => _menuCategoryState();
}

class _menuCategoryState extends State<menuCategory> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
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
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                )),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => menuStatus()),
                    );
                  },
                  icon: Icon(
                    Icons.timer_rounded,
                    size: 30,
                  )),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.green,
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Course Type",
                  icon: Icon(Icons.restaurant_menu_rounded),
                ),
                Tab(text: "Food Type", icon: Icon(Icons.lunch_dining_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: TabBarView(
            children: [
              ///
              ////
              ////
              ///
              //Course

              SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => menuFood()),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
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
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => menuFood()),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
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
                                  'Appetizer',
                                  style: GoogleFonts.cabin(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),

              //
              //
              //
              //
              //FOod
              SingleChildScrollView(
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => menuFood()),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
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
                                  'Dairy',
                                  style: GoogleFonts.cabin(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => menuFood()),
                            );
                          },
                          child: Container(
                            height: 180,
                            width: 180,
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
                                  'Vegan',
                                  style: GoogleFonts.cabin(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            child: Badge(
              badgeContent: Text(
                '3',
                style: GoogleFonts.cabin(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              badgeColor: Colors.teal,
              child: Icon(
                size: 70,
                Icons.shopping_bag_rounded,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.greenAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menuCart()),
              );
            },
          ),
        ),
      ),
    );
  }
}
