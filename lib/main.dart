import 'package:nchatiw_1/Dark%20and%20Light/darkMode.dart';
import 'package:nchatiw_1/Dark%20and%20Light/lightMode.dart';
import 'package:nchatiw_1/Screens/mainScreen.dart';
import 'package:nchatiw_1/screens/chatScreen.dart';
import 'package:nchatiw_1/screens/registerScreen.dart';
import 'package:nchatiw_1/screens/signinScreen.dart';
import 'package:flutter/material.dart';
import 'screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightTheme,
      darkTheme: darkTheme,
      //home: Chatscreen(),
      initialRoute: _auth.currentUser!=null ? MainScreen.screenroute:welcomeScreen.screenroute,
      routes: {
        welcomeScreen.screenroute:(context)=> welcomeScreen(),
        MainScreen.screenroute:(context)=> MainScreen(),
        signinscreen.screenroute:(context)=> signinscreen(),
        Registerscreen.screenroute:(context)=> Registerscreen(),
        Chatscreen.screenroute:(context)=> Chatscreen(),

      }
    );
  }
}

