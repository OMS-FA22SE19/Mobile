import 'package:flutter/material.dart';
import 'package:oms_mobile/Models/course_type.dart';
import 'package:oms_mobile/services/remote_service.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<courseType>? categories;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }

  getData() async {
    categories = await RemoteService().getCourseTypes();
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
        child: Row(
          children: [
            ListView.builder(
              itemCount: categories?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Text(categories![index].name),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
