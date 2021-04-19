import 'package:building/Screens/Home/home.dart';
import 'package:building/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return home or welcome page
    final user = Provider.of<MyUser>(context);
    if (user == null) {
      print("user is null");
      return WelcomeScreen();
    } else {
      print('user is ${user.uid}');
      return Home(user);
    }
  }
}
