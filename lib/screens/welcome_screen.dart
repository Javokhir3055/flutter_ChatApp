import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/components/custom_material_button.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 1), upperBound: 1);
    animationController.forward();
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);
    animationController.addListener(() {
      // setState(() {});
      // print(animation.value);
    });
    //    animation =
//        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
//    animationController.reverse(from: 1.0);

//    animation.addStatusListener((animationStatus) {
//      if (animationStatus == AnimationStatus.completed) {
//        animationController.reverse();
//      } else if (animationStatus == AnimationStatus.dismissed)
//        animationController.forward();
//    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
//                    height: animation.value * 100,
                  ),
                  tag: 'logo',
                ),
                TypewriterAnimatedTextKit(
                  text: ['ChatGo'],
                  isRepeatingAnimation: true,
                  speed: Duration(seconds: 1),
//                '${animationController.value.toInt()}%',
                  textStyle:
                      TextStyle(fontSize: 45.0, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.route);
                  },
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.route);
                  },
                  title: 'Sign in',
                  color: Colors.blueAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
