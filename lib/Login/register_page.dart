// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Login/login_page.dart';
import 'package:get/get.dart';
import 'package:oms_mobile/services/remote_service.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passwordController = TextEditingController();
  bool flagHidden = true;
  bool flagName = false;
  bool flagPhone = false;
  bool flagEmail = false;
  bool flagRePassword = false;
  bool flagPassword = false;
  String errorName = "";
  String errorPhone = "";
  String errorEmail = "";
  String errorPassword = "";
  String errorRePassword = "";

  String? check = "Fail";
  bool checkBool = false;

  @override
  // void dispose() {
  //   phoneController.dispose();
  //   nameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   re_passwordController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
  }

  registerAccount() async {
    check = await RemoteService().registerAccount(nameController.text,
        emailController.text, phoneController.text, passwordController.text);
    if (check?.contains("Created") ?? true) {
      setState(() {
        checkBool = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                color: Colors.greenAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Icon(Icons.restaurant_menu_rounded,
                        color: Colors.white, size: 100),
                  ),
                  Text(
                    'register'.tr.toUpperCase(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (phoneController.text.isEmpty) {
                            setState(() {
                              flagPhone = true;
                              flagHidden = true;
                              errorPhone = 'Please input a number!'.tr;
                            });
                          } else if (phoneController.text.length > 10) {
                            setState(() {
                              flagPhone = true;
                              flagHidden = true;
                              errorPhone = 'Phone number is too long!'.tr;
                            });
                          } else if (phoneController.text.length < 10) {
                            setState(() {
                              flagPhone = true;
                              flagHidden = true;
                              errorPhone =
                                  'Phone number is not long enough!'.tr;
                            });
                          } else {
                            setState(() {
                              flagPhone = false;
                              errorPhone = '';
                            });
                          }
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'phone number'.tr,
                          errorText: flagPhone ? errorPhone.tr : null,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (nameController.text.isEmpty) {
                            setState(() {
                              flagName = true;
                              flagHidden = true;
                              errorName = 'Please input a name!'.tr;
                            });
                          } else {
                            setState(() {
                              flagName = false;
                              errorName = '';
                            });
                          }
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: nameController,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'full name'.tr,
                          errorText: flagName ? errorName : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (emailController.text.isEmpty) {
                            setState(() {
                              flagEmail = true;
                              flagHidden = true;
                              errorEmail = 'Please input a email!'.tr;
                            });
                          } else {
                            if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text)) {
                              setState(() {
                                flagEmail = false;
                                errorEmail = '';
                              });
                            } else {
                              setState(() {
                                flagEmail = true;
                                flagHidden = true;
                                errorEmail = 'Email format wrong!'.tr;
                              });
                            }
                          }
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: emailController,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          errorText: flagEmail ? errorEmail : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (passwordController.text.isEmpty) {
                            setState(() {
                              flagPassword = true;
                              flagHidden = true;
                              errorPassword = 'Please input a password!'.tr;
                            });
                          } else if (passwordController.text.length < 8) {
                            setState(() {
                              flagPassword = true;
                              flagHidden = true;
                              errorPassword = 'Password too short!'.tr;
                            });
                          } else {
                            setState(() {
                              flagPassword = false;
                            });
                          }
                        },
                        obscureText: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: passwordController,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'password'.tr,
                          errorText: flagPassword ? errorPassword : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          if (re_passwordController.text.isEmpty) {
                            setState(() {
                              flagRePassword = true;
                              flagHidden = true;
                              errorRePassword = 'Please input a password!'.tr;
                            });
                          } else {
                            if (re_passwordController.text
                                .contains(passwordController.text)) {
                              setState(() {
                                flagRePassword = false;
                                errorRePassword = ''.tr;
                              });
                            } else {
                              setState(() {
                                flagRePassword = true;
                                flagHidden = true;
                                errorRePassword = 'Password doesn\'t match'.tr;
                              });
                            }
                          }
                          if (flagEmail |
                              flagName |
                              flagPassword |
                              flagPhone |
                              flagRePassword) {
                            setState(() {
                              flagHidden = true;
                            });
                          } else {
                            setState(() {
                              flagHidden = false;
                            });
                          }
                        },
                        obscureText: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        controller: re_passwordController,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'confirm password'.tr,
                          errorText: flagRePassword ? errorRePassword.tr : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            conditionalButton(flagHidden),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Already have an account ?'.tr),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const loginScreen()),
                    );
                  },
                  child: Text(
                    ' ${'Login here!'.tr}',
                    style: const TextStyle(
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
    );
  }

  conditionalButton(bool flag) {
    if (flag) {
      return Container();
    } else {
      return ElevatedButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                alignment: Alignment.center,
                icon: const Icon(Icons.info_outline_rounded),
                title: Text(
                  'Remind'.tr,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Text(
                        'Please remember, any overcharged money won\'t be refund!'
                            .tr
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'If you choose a different table type, table information might be changed'
                            .tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                        ),
                      ),
                    ],
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
          registerAccount();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const loginScreen(),
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.cabin(fontSize: 20, color: Colors.white),
        ),
      );
    }
  }
}
