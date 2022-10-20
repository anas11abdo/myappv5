// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myapp/screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProfile extends StatefulWidget {
  String useremail;
  String username;
  String userphone;
  UsersProfile(
      {Key? key,
      required this.userphone,
      required this.username,
      required this.useremail})
      : super(key: key);

  @override
  State<UsersProfile> createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('images/background.png'),
            ),
            const SizedBox(height: 20),
            Text(
              widget.username.toUpperCase(),
              style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 140, 76, 245),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Flutter Developer'.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'SourceSansPro',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),
            const SizedBox(
              height: 20.0,
              width: 150,
              child: Divider(
                color: Colors.black,
              ),
            ),
            InkWell(
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: Text(
                      widget.userphone,
                      style: const TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          color: Color.fromARGB(255, 140, 76, 245)),
                    ),
                  ),
                ),
                onTap: () {}),
            InkWell(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  title: Text(
                    widget.useremail,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        color: Color.fromARGB(255, 140, 76, 245)),
                  ),
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                logout(context);
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
                    child: const Text('تسجيل خروج'),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('phone');
    preferences.remove('name');
    Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    print("logged out");
  }
}
