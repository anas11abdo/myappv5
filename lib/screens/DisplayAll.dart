// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:myapp/files.dart';

class DisplayAllPage extends StatefulWidget {
  const DisplayAllPage({
    Key? key,
  }) : super(key: key);
  @override
  State<DisplayAllPage> createState() => _DisplayAllPageState();
}

class _DisplayAllPageState extends State<DisplayAllPage> {
  Future<List<Files>> files = GetApp();

  static Future<List<Files>> GetApp() async {
    String url = "http://207.180.221.91:5000/getapps";
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    });
    var rese = json.decode(res.body);
    return rese.map<Files>(Files.fromJson).toList();
  }

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
            child: Text(
              'عرض جميع المعاملات',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 64, 133),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: FutureBuilder<List<Files>>(
                  future: files,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final file = snapshot.data!;
                      return buildFiles(file);
                    } else {
                      return const Text("No user found");
                    }
                  },
                ))));
  }

  Widget buildFiles(List<Files> files) => ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return Card(
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color.fromARGB(255, 167, 104, 238)),
              borderRadius: BorderRadius.circular(20.0)),
          child: ListTile(
            leading: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'images/a.png',
                  ),
                )),
            title: Text(file.first_name+" "+file.last_name),
            subtitle: Text(file.p_id),
          ),
        );
      });
}
