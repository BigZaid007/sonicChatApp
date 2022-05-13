import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic/Screens/chatDetailsScreen.dart';

class Contacts extends StatelessWidget {
  var currentUser=FirebaseAuth.instance.currentUser.uid;
  void callChatScreen(BuildContext context,String name,String uid)
  {

    Navigator.push(context, MaterialPageRoute(builder: (context)=>chatDetailsScreen(
      friendName: name,
      friendUid: uid,
    )));
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").where('uid',isNotEqualTo:currentUser ).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.hasError)
            return Center(
              child: Text('Something went wrong!'),
            );
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          if(snapshot.hasData)
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('People'),
                ),
                SliverList(delegate: SliverChildListDelegate(
                    snapshot.data!.docs.map((DocumentSnapshot document)
                    {
                      Map<String,dynamic> data=document.data();
                      return GestureDetector(
                        onTap: (){
                          callChatScreen(context,data['name'],data['uid']);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(data['name'],style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),
                            subtitle: Text(data['status']),

                          ),
                        ),
                      );
                    }
                    ).toList()
                ))

              ],
            );

          return Container();

        }



    );
  }
}
