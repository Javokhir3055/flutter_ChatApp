import 'package:chat_app/animations/logo_animation.dart';
import 'package:chat_app/components/custom_material_button.dart';
import 'package:chat_app/components/signin_up_text.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;
  var user;
  void login() async {
    try {
      if (RegExp(r'\w@\w.\w').hasMatch(email)) if (password.length > 5) {
        setState(() {
          _showSpinner = true;
        });
        user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          _showSpinner = false;
        });
      }
      if (user != null) {
        Navigator.pushNamed(context, ChatScreen.route);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LogoAnimation(),
              SignInUpText('Login'),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  this.email = value;
                },
                decoration:
                    inputRegistrationScreen.copyWith(hintText: 'Your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  this.password = value;
                },
                maxLines: 1,
                obscureText: true,
                decoration:
                    inputRegistrationScreen.copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlue,
                title: 'Log in',
                onPressed: login,
              ),
            ],
          ),
        ),
        inAsyncCall: _showSpinner,
      ),
    );
  }
}

