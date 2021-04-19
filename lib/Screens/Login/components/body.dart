import 'package:flutter/material.dart';
import 'package:building/Screens/Login/components/background.dart';
import 'package:building/Screens/Signup/signup_screen.dart';
import 'package:building/components/already_have_an_account_acheck.dart';
import 'package:building/components/rounded_button.dart';
import 'package:building/components/rounded_input_field.dart';
import 'package:building/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() => email = value);
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                print(email);
                print(password);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.popAndPushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
