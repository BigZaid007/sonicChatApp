import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("chats").snapshots(),
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
                  largeTitle: Text('Chats'),
                ),
                SliverList(delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map((DocumentSnapshot document)
                      {
                        Map<String,dynamic> data=document.data();
                        return Container();
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
