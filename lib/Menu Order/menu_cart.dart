// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/Menu%20Order/menu_food.dart';
import 'package:oms_mobile/Menu%20Order/menu_status.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:intl/intl.dart' as intl;
import 'package:oms_mobile/Models/order.dart';
import 'package:oms_mobile/Table%20reservation/reservation_preorder_food.dart';
import 'package:oms_mobile/Table%20reservation/reservation_list.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuCart extends StatefulWidget {
  final int reservationId;
  final int categoryId;
  final List<food>? foods;
  String? orderId;
  final isCourse;
  bool? orderFood;
  bool? edit;
  menuCart(
      {super.key,
      required this.foods,
      required this.categoryId,
      this.isCourse,
      this.orderId,
      this.orderFood,
      this.edit,
      required this.reservationId});

  @override
  State<menuCart> createState() => _menuCartState();
}

class _menuCartState extends State<menuCart> {
  int total = 0;
  var isLoaded = true;
  Order? newOrder;
  Order? currentOrder;
  bool check = false;

  String changeFormat(int number) {
    String formated =
        intl.NumberFormat.decimalPattern().format(number).toString();
    return formated;
  }

  @override
  void initState() {
    totalMoney();
    super.initState();
  }

  void totalMoney() {
    setState(() {
      widget.foods?.forEach((element) {
        total = total + element.price * element.quantity;
      });
      int totalQuantity = 0;
      widget.foods?.forEach((element) {
        totalQuantity = totalQuantity + element.quantity;
      });

      if (totalQuantity == 0) {
        isLoaded = false;
      }
    });
  }

  void updatePreOrderFood() async {
    RemoteService().updatePreorderFood(widget.reservationId, widget.foods);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 192, 125, 100),
        centerTitle: true,
        title: Text('Cart'.tr,
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => menuFood(
                          reservationId: widget.reservationId,
                          isCourse: widget.isCourse,
                          categoryId: widget.categoryId,
                          // cartfoods: widget.foods,
                          orderId: widget.orderId,
                        )),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[200],
      body: Visibility(
        visible: isLoaded,
        replacement:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Your cart is empty. Please add some foods!'.tr,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        child: ListView.builder(
          itemCount: widget.foods?.length,
          itemBuilder: (context, index) {
            if (widget.foods![index].quantity != 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(232, 192, 125, 100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.foods![index].name,
                                      style: GoogleFonts.cabin(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${'Price'.tr}: ${changeFormat(widget.foods![index].price)} đ',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.foods![index].quantity =
                                            widget.foods![index].quantity - 1;
                                        if (widget.foods![index].quantity <=
                                            0) {
                                          widget.foods![index].quantity = 0;
                                          widget.foods?.forEach((element) {
                                            if (element.quantity != 0) {
                                              isLoaded = true;
                                            }
                                          });
                                        }
                                      });
                                      total = 0;
                                      totalMoney();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(
                                              232, 192, 125, 100),
                                        ),
                                        child: Icon(
                                          Icons.remove_circle_outline_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    widget.foods![index].quantity.toString(),
                                    style: GoogleFonts.bebasNeue(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.foods![index].quantity =
                                            widget.foods![index].quantity + 1;
                                      });
                                      total = 0;
                                      totalMoney();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(
                                              232, 192, 125, 100),
                                        ),
                                        child: Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'note'.tr,
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              content: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.foods![index].note =
                                                        value;
                                                  });
                                                },
                                                initialValue:
                                                    widget.foods![index].note,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    helperText:
                                                        'Input your note for the food'),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: Text('Done'.tr),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.list_alt_rounded,
                                        size: 20,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Remind'.tr,
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Text(
                                              'Are you really want to remove this item?'
                                                  .tr,
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Text('no'.tr),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widget.foods![index]
                                                        .quantity = 0;
                                                    widget.foods
                                                        ?.forEach((element) {
                                                      if (element.quantity !=
                                                          0) {
                                                        isLoaded = true;
                                                      }
                                                    });
                                                  });
                                                  total = 0;
                                                  totalMoney();
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: Text('yes'.tr),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      total = 0;
                                      totalMoney();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(
                                              232, 192, 125, 100),
                                        ),
                                        child: Icon(
                                          Icons.highlight_remove_rounded,
                                          color: Colors.red,
                                          size: 20,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                height: 10,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // ignore: sort_child_properties_last
        child: Container(
          height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Pay'.tr,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          changeFormat(total),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  conditionalButton(
                      widget.orderFood ?? false, widget.edit ?? false),
                ]),
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  conditionalButton(bool flag, bool edit) {
    if (flag) {
      if (edit) {
        return ElevatedButton(
          onPressed: () {
            updatePreOrderFood();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Remind'.tr,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Your reservation is changed. Process to the menu to check your reservation!'
                        .tr,
                    style: GoogleFonts.lato(
                      color: Colors.black,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => reservationList()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(232, 192, 125, 100),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          child: Text(
            'UPDATE'.tr,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cabin(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => testPrior(
                        reservationId: widget.reservationId,
                        foodList: widget.foods,
                      )),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(232, 192, 125, 100),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          child: Text(
            'CHECK'.tr,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cabin(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        );
      }
    } else {
      return ElevatedButton(
        onPressed: isLoaded
            ? () async {
                if (widget.orderId?.isEmpty == false) {
                  check = widget.orderId?.isEmpty ?? false;
                  newOrder = await RemoteService()
                      .putOrder(widget.orderId ?? "", widget.foods);
                } else {
                  newOrder = await RemoteService()
                      .createOrder(widget.reservationId, widget.foods);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuStatus(
                            reservationId: widget.reservationId,
                            isCourse: widget.isCourse,
                            orderId: newOrder?.id,
                          )),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(232, 192, 125, 100),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        child: Text(
          'CONFIRM'.tr,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cabin(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      );
    }
  }
}
