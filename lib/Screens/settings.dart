import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonic/Screens/landingPage.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>landingPage()));
            },
            child: Text('Settings')),
      ),
    );
  }
}
