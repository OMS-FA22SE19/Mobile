// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_cart.dart';
import 'package:oms_mobile/Menu%20Order/search_page.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/Models/menu.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuFood extends StatefulWidget {
  const menuFood({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<menuFood> createState() => _menuFoodState();
}

class _menuFoodState extends State<menuFood> {
  int counter = 0;
  final String image =
      'https://media.istockphoto.com/photos/cheeseburger-isolated-on-white-picture-id1157515115?k=20&m=1157515115&s=612x612&w=0&h=1-tuF1ovimw3DuivpApekSjJXN5-vc97-qBY5EBOUts=';

  List<menu>? menus;
  List<food>? foods;
  int menuId = 0;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    menus = await RemoteService().getMenuAvailable();
    menus?.forEach((menu) {
      if (menu.isHidden == false) menuId = menu.id;
    });

    foods = await RemoteService().getFoods(menuId, widget.categoryId);
    if (foods != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(
                      builder: (context) => searchPage(
                            categoryId: widget.categoryId,
                            menuId: menuId,
                          )),
                );
              },
              icon: Icon(
                Icons.search_rounded,
                size: 30,
              )),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoaded,
        // child: Center(
        //   child: Container(
        //     width: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: foods?.length,
          padding: EdgeInsets.all(10),
          // scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuFood(
                            categoryId: 1,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 180,
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
                            width: 5,
                          ),
                          Container(
                              height: 150,
                              width: 150,
                              child: Image.network(foods![index].pictureUrl)),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foods![index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Price: ' + foods![index].price.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      foods![index].quantity =
                                          foods![index].quantity + 1;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Add to cart',
                                      style: GoogleFonts.cabin(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
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
      floatingActionButton: FloatingActionButton.large(
        child: Badge(
          badgeContent: Text(
            '$counter',
            style: GoogleFonts.cabin(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
            MaterialPageRoute(
                builder: (context) => menuCart(
                      foods: foods,
                    )),
          );
        },
      ),
    );
  }
}
