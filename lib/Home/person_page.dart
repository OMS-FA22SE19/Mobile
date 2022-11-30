import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_mobile/Home/home_screen.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  String selectionLanguage = "ENGLISH";
  final usernameController = TextEditingController(text: "User Default");
  final phoneController = TextEditingController(text: "0909090909");
  bool checkSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('Profile'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 30,
                        )),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 70, 70, 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black,
                                blurStyle: BlurStyle.outer)
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.person,
                          size: 150,
                          color: Colors.green,
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
            Text('${'full name'.tr}:',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  color: Colors.black,
                  fontSize: 20,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {},
                    controller: usernameController,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input number of guest'.tr,
                      // labelText: 'Input number of guest',
                      // errorText: flagText ? 'Please input a number!'.tr : null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('${'phone number'.tr}:',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  color: Colors.black,
                  fontSize: 20,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {},
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input number of guest'.tr,
                      // labelText: 'Input number of guest',
                      // errorText: flagText ? 'Please input a number!'.tr : null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Language: $selectionLanguage',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                Switch(
                  // This bool value toggles the switch.
                  value: checkSwitch,
                  thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                  activeColor: Colors.greenAccent,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      checkSwitch = value;
                      if (checkSwitch) {
                        var locale = Locale('vi', 'VN');
                        Get.updateLocale(locale);
                        setState(() {
                          selectionLanguage = "Tiếng Việt";
                        });
                      } else {
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);
                        setState(() {
                          selectionLanguage = "English";
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                    MaterialPageRoute(builder: (context) => const homeScreen()),
                  );
                },
                child: Text(
                  'home'.tr.toUpperCase(),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         var locale = Locale('en', 'US');
            //         Get.updateLocale(locale);
            //         setState(() {
            //           selectionLanguage = "English";
            //         });
            //       },
            //       child: Container(
            //         width: 100,
            //         color: Colors.green,
            //         child: Text("English",
            //             style: GoogleFonts.bebasNeue(
            //               color: Colors.white,
            //               fontSize: 20,
            //             )),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         var locale = Locale('vi', 'VN');
            //         Get.updateLocale(locale);
            //         setState(() {
            //           selectionLanguage = "Tiếng Việt";
            //         });
            //       },
            //       child: Container(
            //         width: 100,
            //         color: Colors.red,
            //         child: Text("Tiếng Việt",
            //             style: GoogleFonts.bebasNeue(
            //               color: Colors.white,
            //               fontSize: 20,
            //             )),
            //       ),
            //     )
            //   ],
            // ),
            // BlocBuilder<LanguageCubit, Locale?>(
            //   builder: ((context, state) {
            //     return
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
