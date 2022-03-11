import 'package:statschat/constants.dart';
import 'package:flutter/material.dart';
import 'package:statschat/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:statschat/screens/chat_screen.dart';
import 'package:statschat/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool progressSpinner = false;
  final _authentication = FirebaseAuth.instance;
  late var controller;
  late var animation;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    Animation<double> opacity =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: progressSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: progressSpinner,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: dHeight * 0.2,
                horizontal: dWidth * 0.05 * 0.1 +
                    (animation.value * (dWidth * 0.05) * 0.9),
              ),
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: (dHeight * 0.1) * 0.8 +
                        (animation.value * (dHeight * 0.1) * 0.5),
                    // 0.8 means starts at 80% height and increases 20% as 0.2 at right
                    child: Image.asset(
                      'images/logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: (dHeight * 0.1) - controller.value * (dHeight * 0.05),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Login',
                    style: kHeadingStyle.copyWith(
                        fontFamily: 'Comforter', letterSpacing: 5),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightGreen, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 32 * 0.9 - animation.value * 32 * 0.5,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightGreen, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                MainButton(
                  text: 'Log in',
                  color: Colors.lightGreen,
                  onPressed: () async {
                    setState(() {
                      progressSpinner = true; // start the loading spinner
                    });
                    try {
                      final UserCredential? user =
                          await _authentication.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (user != null) {
                        Navigator.of(context).pushNamed(ChatScreen.routeName);
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed(WelcomeScreen.routeName);
                      }
                      setState(() {
                        progressSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        progressSpinner = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Error',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: const Text(
                              'Invalid email or password!',
                              style: TextStyle(color: Colors.grey),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    } // stop the loading spinner
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
