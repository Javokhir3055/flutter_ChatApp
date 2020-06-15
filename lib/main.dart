import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData.dark().copyWith(textTheme: TextTheme(
//        body1: TextStyle(color: Colors.black54 )
//      )),
      initialRoute: WelcomeScreen.route,
      onUnknownRoute: (route){
        return MaterialPageRoute(builder: (BuildContext context) {
          return WelcomeScreen();
        });
      },
      routes:{
        WelcomeScreen.route:(context)=>WelcomeScreen(),
        RegistrationScreen.route:(context)=>RegistrationScreen(),
        LoginScreen.route:(context)=>LoginScreen(),
        ChatScreen.route:(context)=>ChatScreen(),
      },
    );
  }
}
