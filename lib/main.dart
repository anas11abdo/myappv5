import 'package:flutter/material.dart';
import 'package:myapp/screens/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  var phone = preferences.getString('phone');
  var name = preferences.getString('name');
  runApp(MaterialApp(
    home: email == null || phone == null || name == null 
    ? LoginPage() : nav(useremail: email, userphone: phone, username: name),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'تطبيق معاملات',
      theme: ThemeData(),
      home: LoginPage(),
    );
  }
}
