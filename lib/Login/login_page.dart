// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Login/register_page.dart';
import 'package:oms_mobile/services/remote_service.dart';
import '../Home/home_screen.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String? phone;
  String? password;
  bool flagPhone = false;
  bool flagPassword = false;
  bool loginFailed = false;
  String? jwttoken;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  getData() async {
    getAuth();
  }

  getAuth() async {
    jwttoken = await RemoteService().getAuthToken(phone, password);
    if (jwttoken == null) {
      setState(() {
        loginFailed = true;
      });
    } else {
      setState(() {
        loginFailed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.restaurant_menu_rounded,
                    size: 100,
                  ),
                ),
                //welcome text
                Text('hello customer'.tr,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 36,
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Long time no see, you have been missed!'.tr,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Phone
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
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              flagPhone = false;
                              phone = phoneController.text;
                            });
                          }
                          getAuth();
                        },
                        controller: phoneController,
                        scrollPhysics: const BouncingScrollPhysics(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input your phone number'.tr,
                            errorText:
                                flagPhone ? "This field is empty".tr : null),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //password
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
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              flagPassword = false;
                              password = passwordController.text;
                            });
                          }
                          getAuth();
                        },
                        controller: passwordController,
                        scrollPhysics: const BouncingScrollPhysics(),
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input your password'.tr,
                            errorText:
                                flagPassword ? "This field is empty".tr : null),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Login button
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
                      if (phoneController.text.isEmpty) {
                        setState(() {
                          getAuth();
                          flagPhone = true;
                        });
                      } else if (passwordController.text.isEmpty) {
                        setState(() {
                          getAuth();
                          flagPassword = true;
                        });
                      } else if (passwordController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        getAuth();
                      }
                      if (jwttoken == null) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Invalid'.tr,
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "Your password or email doesn't right. Please try again!"
                                    .tr,
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('I understand'.tr),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homeScreen(
                                    jwtToken: '$jwttoken',
                                  )),
                        );
                      }
                    },
                    child: Text(
                      'login'.tr.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //Register button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a customer?'.tr),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registerPage()),
                        );
                      },
                      child: Text(
                        ' ${'Register now!'.tr}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
