import 'package:app_flat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'Login/LoginScreen.dart';

void main() => runApp(LocaVacance());

class LocaVacance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.id, //LoginSignupPage.id,
      routes: {
        LoginSignupPage.id: (context) => LoginSignupPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
