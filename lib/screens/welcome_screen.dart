import 'package:statschat/constants.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:statschat/main_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late var controller;
  late var animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('images/background4.jpg'), //4
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30 * 0.5 + animation.value * 30 * 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: (dHeight * 0.08) * 0.1 +
                            animation.value * (dHeight * 0.08) * 0.9,
                        child: const Image(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ColorizeAnimatedTextKit(
                      text: const ['StatSchat'],
                      textStyle: kTitleStyle,
                      colors: const [
                        Colors.blueAccent,
                        Colors.yellow,
                        Colors.red,
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              MainButton(
                text: 'Log in',
                color: Colors.lightGreen,
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  });
                },
              ),
              MainButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < 1000; i++) {
                      int k = 0;
                    }
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
