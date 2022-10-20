import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/per_user.dart';
import 'package:myapp/screens/NewAppinfo.dart';
import 'package:myapp/screens/personapps.dart';
import 'package:myapp/screens/widgets/header_widget.dart';
import 'package:myapp/screens/widgets/theme_helper.dart';

class NewAPP extends StatefulWidget {
   NewAPP({Key? key, 
      required this.useremail,
      required this.userphone,
      required this.username}) : super(key: key);
  String username;
  String useremail;
  String userphone;

  @override
  State<NewAPP> createState() => _NewAPPState();
}

class _NewAPPState extends State<NewAPP> {
  int currentStep = 0;
  PerUser perUser = PerUser(DOB: DateTime.now(), prs_name: '', prs_id: '');
  final first_name = TextEditingController();
  final last_name = TextEditingController();

  Future newAPP() async {
    var res = await http.post(
        Uri.parse("http://207.180.221.91:5000/getpersonalinfo"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'prs_id': perUser.prs_id,
        });

    var rese = json.decode(res.body);
    if (rese.toString() == '[]') {
      rese = "[]";
    } else {
      var pid = rese[0]['PER_ID'].toString();
      var pname = rese[0]['PER_NAME'].toString();
      var plastname = rese[0]['PER_LASTNAME'].toString();
      var pdate = DateTime.parse(rese[0]['PER_BOD'].toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NewAPPinfo(id: pid, name: pname,lastname:plastname, dob: pdate,userphone: widget.userphone,
        username: widget.username,
        useremail: widget.useremail)));
    }
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
              'اضافة معاملة جديده',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 64, 133),
        ),
        body: SingleChildScrollView(child: Stack(children: [
      Container(
        height: 150,
        child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
      ),
      Container(
          child: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 250, 10, 10),
          child: TextFormField(
            controller: TextEditingController(text: perUser.prs_id),
            decoration: const InputDecoration(
              labelText: ' الرجاء ادخال رقم هوية',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
            onChanged: (value) {
              perUser.prs_id = value;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            RaisedButton(
              onPressed: () {
                newAPP();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ]),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: const Text('تأكيد المعلومات'),
                  )),
            ),
            SizedBox(width:20),
        RaisedButton(
              onPressed: () {
                print(perUser.prs_id.toString());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonApps(id: perUser.prs_id.toString())));
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ]),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: const Text('عرض معاملات الرقم'),
                  )),
            ),
        ])]))
    ])));
  }
}
