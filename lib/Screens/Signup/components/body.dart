import 'package:building/model/user.dart';
import 'package:building/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:building/Screens/Signup/components/background.dart';
import 'package:building/Screens/Signup/components/or_divider.dart';
import 'package:building/Screens/Signup/components/social_icon.dart';
import 'package:building/components/already_have_an_account_acheck.dart';
import 'package:building/components/rounded_button.dart';
import 'package:building/components/rounded_input_field.dart';
import 'package:building/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  double errorFontSize = 0.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: errorFontSize,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: errorFontSize),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      setState(() {
                        setState(() {
                          email = value;
                          error = '';
                          errorFontSize = 0;
                        });
                      });
                    },
                  ),
                  RoundedPasswordField(onChanged: (value) {
                    setState(() {
                      setState(() {
                        password = value;
                        error = '';
                        errorFontSize = 0;
                      });
                    });
                  }),
                  RoundedButton(
                    text: "SIGNUP",
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        // print(email);
                        // print(password);
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result is MyUser) {
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            error = result.split(']')[1];
                            errorFontSize = 14.0;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.popAndPushNamed(context, '/login');
              },
            ),
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
