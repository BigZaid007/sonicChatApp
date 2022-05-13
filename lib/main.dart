import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic/Screens/HomeScreen.dart';
import 'package:sonic/Screens/landingPage.dart';
import 'package:sonic/loginScreen/hello.dart';
import 'package:sonic/loginScreen/userName.dart';

import 'loginScreen/verifyNumber.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myApp());
}

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor:Color(0xff1971c2),
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
      home: landingPage(),
    );
  }
}


