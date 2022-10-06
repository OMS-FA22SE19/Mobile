// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_cart.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';
import 'package:oms_mobile/Menu%20Order/menu_status.dart';
import 'package:badges/badges.dart';
import 'package:oms_mobile/Models/course_type.dart';
import 'package:oms_mobile/Models/food_type.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuCategory extends StatefulWidget {
  const menuCategory({super.key});

  @override
  State<menuCategory> createState() => _menuCategoryState();
}

class _menuCategoryState extends State<menuCategory> {
  List<courseType>? courses;
  List<foodType>? foodTypes;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    courses = await RemoteService().getCourseTypes();
    foodTypes = await RemoteService().getFoodTypes();
    if (courses != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

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
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => menuStatus()),
            //         );
            //       },
            //       icon: Icon(
            //         Icons.timer_rounded,
            //         size: 30,
            //       )),
            // ],
            bottom: const TabBar(
              indicatorColor: Colors.green,
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: "Courses",
                  icon: Icon(Icons.ramen_dining_rounded),
                ),
                Tab(text: "Foods", icon: Icon(Icons.brunch_dining_rounded)),
              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: TabBarView(
            children: [
              //TAB 1: COURSE TYPE
              Visibility(
                visible: isLoaded,
                // child: Center(
                //   child: Container(
                //     width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: courses?.length,
                  padding: EdgeInsets.all(10),
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => menuFood(
                                    categoryId: courses![index].id,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 120,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.fastfood_outlined,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Text(
                                      courses![index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //   ),
                // ),
              ),

              //TAB 2: FOOD TYPE
              Visibility(
                visible: isLoaded,
                // child: Center(
                //   child: Container(
                //     width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodTypes?.length,
                  padding: EdgeInsets.all(10),
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => menuFood(
                                    categoryId: foodTypes![index].id,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 120,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.fastfood_outlined,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Text(
                                      foodTypes![index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //   ),
                // ),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton.large(
          //   child: Badge(
          //     badgeContent: Text(
          //       '3',
          //       style: GoogleFonts.cabin(
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white),
          //     ),
          //     badgeColor: Colors.teal,
          //     child: Icon(
          //       size: 70,
          //       Icons.shopping_bag_rounded,
          //       color: Colors.white,
          //     ),
          //   ),
          //   backgroundColor: Colors.greenAccent,
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => menuCart()),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
