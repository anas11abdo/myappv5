// ignore_for_file: file_names

import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    Key? key,
  }) : super(key: key);
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ]),
            ),
          ),
          shadowColor: Colors.blue,
          title: const Center(
            child: Text('معلومات التطبيق'),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "تطبيق معاملات",
                  style: TextStyle(
                      fontSize: 40, color: Color.fromARGB(255, 143, 115, 245)),
                ),
              ),
              Center(
                  child: Text("النسخة1.1.1",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 143, 115, 245))))
            ]));
  }
}



// Text(widget.jsondata[0]["uname"].toString())