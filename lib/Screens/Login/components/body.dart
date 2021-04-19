import 'package:building/model/user.dart';
import 'package:building/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:building/Screens/Login/components/background.dart';
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
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';
  double errorFontSize = 0.0;

  final _formKey = GlobalKey<FormState>();

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
            SizedBox(
              height: errorFontSize,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: errorFontSize),
            ),
            Form(
                key: _formKey,
                child: Column(children: [
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
                  RoundedPasswordField(
                    onChanged: (value) {
                      setState(() {
                        setState(() {
                          password = value;
                          error = '';
                          errorFontSize = 0;
                        });
                      });
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        print(email);
                        print(password);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
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
                ])),
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
