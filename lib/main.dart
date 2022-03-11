import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

const cloudMessagingKey =
    'AAAAOTk6AIM:APA91bEKbzKj3WAzka8eTEwzDGqzawsa1GxmoqB4CPdwZ7g4XS_hC6NN4rMGYpYo3A0FR2oGRZTKbV5xKbKryskBt1A360HJk3sazAIu17xzWXRz2eyC4D-y2YQqeFAxT2vY0VRLQLkf';
const webApiKey = 'AIzaSyAfBvDa0K6MEY9XDDBpa29V_3qXgk6QAjw';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: webApiKey,
          appId: 'co.cruzerblade.statschat',
          messagingSenderId: cloudMessagingKey,
          projectId: 'statschat-f3247'),
    );
  } catch (e) {
    print('something went wrong!!');
  }
  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
      },
    );
  }
}
