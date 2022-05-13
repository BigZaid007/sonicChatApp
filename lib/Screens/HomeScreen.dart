import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic/Screens/calls.dart';
import 'package:sonic/Screens/chats.dart';
import 'package:sonic/Screens/people.dart';
import 'package:sonic/Screens/settings.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Color blue=Color(0xff1971c2);

  var Screens=[Chats(),Calls(),Contacts(),Settings()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(CupertinoIcons.chat_bubble),),
          BottomNavigationBarItem(
            label: 'Calls',
            icon: Icon(CupertinoIcons.phone),),
          BottomNavigationBarItem(
            label: 'Contacts',
            icon: Icon(CupertinoIcons.person_alt_circle_fill),),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(CupertinoIcons.settings),),


        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return Screens[index];
    },
    ),);
  }
}
