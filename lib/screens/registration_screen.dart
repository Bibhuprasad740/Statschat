import 'package:flutter/material.dart';
import 'package:statschat/constants.dart';
import 'package:statschat/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:statschat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration-screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  bool progressSpinner = false;
  final _authentication = FirebaseAuth.instance;
  late var controller;
  late var animation;
  late var opacity;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    opacity = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = 'Statschat!';
    String email = 'example@gmail.com';
    String password = 'password';
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: progressSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background6.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: dHeight * 0.2,
              horizontal: dWidth * 0.05,
            ),
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: (dHeight * 0.1) * 0.8 +
                      (animation.value * (dHeight * 0.1) * 0.2),
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Register',
                  style: kHeadingStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your name',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 64 * 0.9 - animation.value * 64 * 0.7,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 64 * 0.9 - animation.value * 64 * 0.7,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter a Strong password',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              MainButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    progressSpinner = true;
                  });
                  try {
                    final UserCredential? credential =
                        await _authentication.createUserWithEmailAndPassword(
                            email: email, password: password);
                    // to store the name while registering the user
                    if (credential != null) {
                      User? user = credential.user;
                      user?.updateDisplayName(
                          name); // store the name while authenticating
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
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
                          content: Text(
                            e.toString(),
                            style: const TextStyle(color: Colors.grey),
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
