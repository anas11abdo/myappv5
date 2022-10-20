// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:myapp/screens/DisplayAll.dart';
import 'package:myapp/screens/NewAPP.dart';
import 'package:myapp/screens/SearchPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key,
      required this.useremail,
      required this.userphone,
      required this.username}) : super(key: key);
  String username;
  String useremail;
  String userphone;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              'الرئيسيه',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 64, 133),
        ),
        body: Center(
          child: Container(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              primary: false,
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.question_answer_outlined,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Center(
                                child: Text(
                                  "استفسار",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                              )
                            ])),
                  ),
                  color: const Color.fromARGB(255, 167, 104, 238),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAPP(useremail: widget.useremail, userphone: widget.userphone, username: widget.username)));
                    },
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.input_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "ادخال معامله",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ])),
                  ),
                  color: Color.fromARGB(255, 167, 104, 238),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayAllPage()));
                    },
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.show_chart_outlined,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "عرض المعاملات",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ])),
                  ),
                  color: const Color.fromARGB(255, 167, 104, 238),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.picture_as_pdf,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "تحميل PDF",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ])),
                  ),
                  color: Color.fromARGB(255, 167, 104, 238),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
