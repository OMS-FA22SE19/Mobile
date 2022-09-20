// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';
import 'package:oms_mobile/Table%20reservation/table_information.dart';

class tableUser extends StatelessWidget {
  final String date;
  final String time;
  const tableUser({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    final nameController1 = TextEditingController();
    final nameController2 = TextEditingController();
    final phoneController1 = TextEditingController();
    final phoneController2 = TextEditingController();

    @override
    void dispose() {
      nameController1.dispose();
      nameController2.dispose();
      phoneController1.dispose();
      phoneController2.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "INFORMATION FORM",
                style:
                    GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "User",
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController1,
                      autofocus: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: 'Input your name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneController1,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_rounded,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: 'Input your phone number',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Reservation for",
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: 'Input your name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_rounded,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: 'Input your phone number',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: Size(double.infinity, 35),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => tableInformation(
                                name: nameController1.text,
                                phone: phoneController1.text,
                                date: date,
                                time: time,
                              )),
                    );
                  },
                  child: Text(
                    'Confirm'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}


// class tableUser extends StatefulWidget {
//   final String date;
//   final String time;
//   const tableUser({super.key, required this.date, required this.time});

//   @override
//   State<tableUser> createState() => _tableUserState();
// }

// class _tableUserState extends State<tableUser> {
//   final nameController1 = TextEditingController();
//   final nameController2 = TextEditingController();
//   final phoneController1 = TextEditingController();
//   final phoneController2 = TextEditingController();

//   @override
//   void dispose() {
//     nameController1.dispose();
//     nameController2.dispose();
//     phoneController1.dispose();
//     phoneController2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: SafeArea(
//           child: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text(
//                 "INFORMATION FORM",
//                 style:
//                     GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "User",
//                 style:
//                     GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: nameController1,
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.person,
//                           size: 20,
//                         ),
//                         border: InputBorder.none,
//                         hintText: 'Input your name',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: phoneController1,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.phone_rounded,
//                           size: 20,
//                         ),
//                         border: InputBorder.none,
//                         hintText: 'Input your phone number',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Reservation for",
//                 style:
//                     GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.person,
//                           size: 20,
//                         ),
//                         border: InputBorder.none,
//                         hintText: 'Input your name',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.phone_rounded,
//                           size: 20,
//                         ),
//                         border: InputBorder.none,
//                         hintText: 'Input your phone number',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.greenAccent,
//                     minimumSize: Size(double.infinity, 35),
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                   ),
//                   onPressed: () {
//                     // showDialog(
//                     //   context: context,
//                     //   builder: (context) {
//                     //     return AlertDialog(
//                     //       // Retrieve the text that the user has entered by using the
//                     //       // TextEditingController.
//                     //       content: Text(phoneController1.text),
//                     //     );
//                     //   },
//                     // );
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => tableInformation(
//                                 name: nameController1.text,
//                                 phone: phoneController1.text,
//                               )),
//                     );
//                   },
//                   child: Text(
//                     'Confirm'.toUpperCase(),
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
