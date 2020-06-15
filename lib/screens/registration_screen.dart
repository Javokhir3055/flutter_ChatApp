import 'package:chat_app/animations/logo_animation.dart';
import 'package:chat_app/components/custom_material_button.dart';
import 'package:chat_app/components/signin_up_text.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "RegistrationScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;

  void createUser() async {
    try {
      if (RegExp(r"\w@\w.\w", caseSensitive: false)
          .hasMatch(email)) if (password.length > 5) {
        setState(() {
          _showSpinner = true;
        });
        var newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          _showSpinner = false;
        });
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
              SignInUpText('Sign In'),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    inputRegistrationScreen.copyWith(hintText: 'Your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration:
                      inputRegistrationScreen.copyWith(hintText: 'Password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blue,
                title: 'Sign in',
                onPressed: createUser,
              ),
            ],
          ),
        ),
        inAsyncCall: _showSpinner,
      ),
    );
  }
}
