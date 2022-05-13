import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonic/Screens/HomeScreen.dart';
import 'package:sonic/loginScreen/hello.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  User _user=FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return _user!=null?HomeScreen():hello();
  }
}
