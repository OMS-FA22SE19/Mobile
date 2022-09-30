import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oms_mobile/Models/food_category.dart';
import 'package:oms_mobile/main.dart';
import 'package:oms_mobile/services/remote_service.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Datum>? categories;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }

  getData() async {
    await ARemoteService().getCategories();
    if (categories != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test',
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: categories?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  color: Colors.amber,
                  child: Text(categories![index].toString()),
                ),
              ],
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
