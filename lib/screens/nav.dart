// ignore_for_file: camel_case_types

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/InfoPage.dart';
import 'package:myapp/screens/UesrProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class nav extends StatefulWidget {
  String username;
  String useremail;
  String userphone;
  nav(
      {Key? key,
      required this.useremail,
      required this.userphone,
      required this.username})
      : super(key: key);

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  Future getemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

  }

  int selectedpage = 1;
  late final _pageOption = [
    UsersProfile(
        userphone: widget.userphone,
        username: widget.username,
        useremail: widget.useremail),
    HomePage(userphone: widget.userphone,
        username: widget.username,
        useremail: widget.useremail),
    InfoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(143, 148, 251, 1),
          Color.fromRGBO(143, 148, 251, .6),
        ]),
        items: [
          TabItem(
            icon: Icons.person,
            title: "الملف الشخصي",
          ),
          TabItem(icon: Icons.home, title: "الرئيسيه"),
          TabItem(icon: Icons.info, title: "معلومات"),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }
}
