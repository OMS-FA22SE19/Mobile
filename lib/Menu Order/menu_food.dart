// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Menu%20Order/menu_cart.dart';
import 'package:oms_mobile/Menu%20Order/menu_food_detaiil.dart';
import 'package:oms_mobile/Menu%20Order/search_page.dart';
import 'package:oms_mobile/Models/food.dart';
import 'package:oms_mobile/services/remote_service.dart';

class menuFood extends StatefulWidget {
  const menuFood({super.key, required this.id});

  final int id;
  @override
  State<menuFood> createState() => _menuFoodState();
}

class _menuFoodState extends State<menuFood> {
  int counter = 0;
  final String image =
      'https://media.istockphoto.com/photos/cheeseburger-isolated-on-white-picture-id1157515115?k=20&m=1157515115&s=612x612&w=0&h=1-tuF1ovimw3DuivpApekSjJXN5-vc97-qBY5EBOUts=';

  void _increaseCounter() {
    setState(() {
      counter = counter + 1;
    });
  }

  void _decreaseCounter() {
    setState(() {
      counter = counter - 1;
      if (counter < 0) counter = 0;
    });
  }

  List<food>? foods;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    foods = await RemoteService().getFoods();
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
                  MaterialPageRoute(builder: (context) => searchPage()),
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
                            id: 1,
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
                              foods![index].name,
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
            MaterialPageRoute(builder: (context) => menuCart()),
          );
        },
      ),
    );
  }
}

// SafeArea(
//           child: SingleChildScrollView(
//         child: Center(
//           child: Column(children: [
//             SizedBox(
//               height: 20,
//             ),

//             //no amount
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.greenAccent,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => menuFoodDetail(
//                                         name: 'Hambuger',
//                                         image: image,
//                                       )),
//                             );
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image(
//                               image: NetworkImage(image),
//                               width: 150,
//                               height: 150,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Hamburger',
//                                 style: GoogleFonts.lato(
//                                     fontSize: 25,
//                                     fontStyle: FontStyle.italic,
//                                     color: Colors.white),
//                               ),
//                               Text(
//                                 '10 mins',
//                                 style: GoogleFonts.lato(
//                                     fontSize: 20,
//                                     fontStyle: FontStyle.italic,
//                                     color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => menuCart()),
//                                   );
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 40,
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: Text(
//                                     'CHOOSE',
//                                     style: TextStyle(
//                                       color: Colors.greenAccent,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
            
//             //AMOUNT
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(12),
//             //         color: Colors.greenAccent,
//             //       ),
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(5.0),
//             //         child: Row(
//             //           children: [
//             //             InkWell(
//             //               onTap: () {
//             //                 Navigator.push(
//             //                   context,
//             //                   MaterialPageRoute(
//             //                       builder: (context) => menuFoodDetail(
//             //                             name: 'Hambuger',
//             //                             image: image,
//             //                           )),
//             //                 );
//             //               },
//             //               child: ClipRRect(
//             //                 borderRadius: BorderRadius.circular(12),
//             //                 child: Image(
//             //                   image: NetworkImage(image),
//             //                   width: 150,
//             //                   height: 150,
//             //                   fit: BoxFit.fill,
//             //                 ),
//             //               ),
//             //             ),
//             //             SizedBox(
//             //               width: 20,
//             //             ),
//             //             Padding(
//             //               padding: const EdgeInsets.all(8.0),
//             //               child: Column(
//             //                 children: [
//             //                   Text(
//             //                     'Hamburger',
//             //                     style: GoogleFonts.lato(
//             //                         fontSize: 25,
//             //                         fontStyle: FontStyle.italic,
//             //                         color: Colors.white),
//             //                   ),
//             //                   Text(
//             //                     '10 mins',
//             //                     style: GoogleFonts.lato(
//             //                         fontSize: 20,
//             //                         fontStyle: FontStyle.italic,
//             //                         color: Colors.white),
//             //                   ),
//             //                   SizedBox(
//             //                     height: 20,
//             //                   ),
//             //                   Row(
//             //                     mainAxisAlignment:
//             //                         MainAxisAlignment.spaceBetween,
//             //                     children: [
//             //                       InkWell(
//             //                         onTap: () {
//             //                           _decreaseCounter();
//             //                         },
//             //                         child: Container(
//             //                           alignment: Alignment.center,
//             //                           decoration: BoxDecoration(
//             //                             shape: BoxShape.circle,
//             //                             color: Colors.greenAccent,
//             //                           ),
//             //                           child: Text(
//             //                             '-',
//             //                             style: TextStyle(
//             //                               color: Colors.white,
//             //                               fontWeight: FontWeight.bold,
//             //                               fontSize: 30,
//             //                             ),
//             //                           ),
//             //                         ),
//             //                       ),
//             //                       SizedBox(
//             //                         width: 20,
//             //                       ),
//             //                       Text(
//             //                         '$counter',
//             //                         style: GoogleFonts.bebasNeue(
//             //                           color: Colors.white,
//             //                           fontWeight: FontWeight.normal,
//             //                           fontSize: 20,
//             //                         ),
//             //                       ),
//             //                       SizedBox(
//             //                         width: 20,
//             //                       ),
//             //                       InkWell(
//             //                         onTap: () {
//             //                           _increaseCounter();
//             //                         },
//             //                         child: Container(
//             //                           alignment: Alignment.center,
//             //                           decoration: BoxDecoration(
//             //                             shape: BoxShape.circle,
//             //                             color: Colors.greenAccent,
//             //                           ),
//             //                           child: Text(
//             //                             '+',
//             //                             style: TextStyle(
//             //                               color: Colors.white,
//             //                               fontWeight: FontWeight.bold,
//             //                               fontSize: 30,
//             //                             ),
//             //                           ),
//             //                         ),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ],
//             //               ),
//             //             )
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ]),
//         ),
//       )),