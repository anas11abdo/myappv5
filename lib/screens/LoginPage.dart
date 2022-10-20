import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/nav.dart';
import 'package:myapp/users.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  User user = User('', '');
  String url = "http://207.180.221.91:5000/login";

  Future save() async {
    var res = await http.post(Uri.parse(url), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'email': user.email,
      'password': user.password
    });
    var rese = json.decode(res.body);
    var useremail;
    var username;
    var userphone;
    if (rese.toString() == '[]') {
      useremail = "[]";
    } else {
      useremail = rese[0]['email'].toString();
      username = rese[0]['UNAME'].toString();
      userphone = rese[0]['USER_PHONE'].toString();
    }
    print(useremail);

    if (useremail == user.email) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', useremail);
      preferences.setString('phone', userphone);
      preferences.setString('name', username);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => nav(
                  useremail: useremail,
                  userphone: userphone,
                  username: username)));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("تسجيل الدخول غير صحيح"),
          content: const Text(
              "لا يوجد مستخدم بكلمة السر او البريد الالكتروني المدخل الرجاء التحقق منهم او التسجيل في التطبيق"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: const Color.fromARGB(255, 104, 181, 243),
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "حسنا",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-2.png'))),
                        ),
                      ),
                      Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/clock.png'))),
                          )),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    controller:
                                        TextEditingController(text: user.email),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    onChanged: (value) {
                                      user.email = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ادخل البريد الالكتروني';
                                      } else if (RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return "ادخل بريدا الكترونيا متاحا";
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: TextEditingController(
                                        text: user.password),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    onChanged: (value) {
                                      user.password = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ادخل الرقم السري';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("OK");
                              } else {
                                print("something went wrong !!!");
                              }
                              save();
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(colors: <Color>[
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: const Text('LOGIN'),
                                )),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
