import 'package:firebase_core/firebase_core.dart';
import 'package:building/Screens/Login/login_screen.dart';
import 'package:building/Screens/Signup/signup_screen.dart';
import 'package:building/services/auth.dart';
import 'package:building/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:building/constants.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
        value: AuthService().user,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Building',
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
            ),
            // home: WelcomeScreen(),
            routes: {
              '/': (context) => Wrapper(),
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignUpScreen(),
            }));
  }
}
