// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Menu%20Order/menu_cart.dart';
import 'package:oms_mobile/Menu%20Order/menu_category.dart';
import 'package:oms_mobile/Menu%20Order/menu_food_detaiil.dart';
import 'package:oms_mobile/Menu%20Order/search_page.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/Models/menu.dart';
import 'package:oms_mobile/services/remote_service.dart';
import 'package:intl/intl.dart' as intl;

class menuFood extends StatefulWidget {
  menuFood(
      {super.key,
      required this.categoryId,
      required this.isCourse,
      required this.reservationId,
      this.orderId,
      this.cartfoods,
      this.orderFood,
      this.edit});
  final int reservationId;
  final int categoryId;
  final bool isCourse;
  String? orderId;
  List<food>? cartfoods;
  bool? orderFood;
  bool? edit;

  @override
  State<menuFood> createState() => _menuFoodState();
}

class _menuFoodState extends State<menuFood> {
  int counter = 0;
  List<menu>? menus;
  List<food>? foods;
  List<food>? cartfoods;
  int menuId = 0;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  count() {
    counter = 0;
    foods?.forEach((element) {
      counter = element.quantity + counter;
    });
  }

  getData() async {
    menus = await RemoteService().getMenuAvailable();
    menus?.forEach((menu) {
      if (menu.available == true) menuId = menu.id;
    });

    foods = await RemoteService()
        .getFoods(menuId, widget.categoryId, widget.isCourse);
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
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('Menu',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => menuCategory(
                          reservationId: widget.reservationId,
                          isCourse: widget.isCourse,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
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
                            reservationId: widget.reservationId,
                            isCourse: widget.isCourse,
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
                      builder: (context) => menuFoodDetail(
                            reservationId: widget.reservationId,
                            isCourse: widget.isCourse,
                            categoryId: widget.categoryId.toString(),
                            foodId: foods![index].id.toString(),
                            price: foods![index].price,
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
                    color: Color.fromRGBO(232, 192, 125, 100),
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
                                  'Price: ' + changeFormat(foods![index].price),
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
                                      count();
                                      cartfoods = foods;
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
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => menuCart(
                      reservationId: widget.reservationId,
                      isCourse: widget.isCourse,
                      categoryId: widget.categoryId,
                      foods: cartfoods,
                      orderId: widget.orderId,
                      orderFood: widget.orderFood,
                      edit: widget.edit,
                    )),
          );
        },
        child: Badge(
          badgeContent: Text(
            // cartfoods?.length.toString() ?? "",
            counter.toString(),
            style: GoogleFonts.cabin(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          badgeColor: Colors.brown,
          child: Icon(
            size: 70,
            Icons.shopping_bag_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
