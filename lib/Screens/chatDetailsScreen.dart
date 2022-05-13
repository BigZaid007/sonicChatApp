

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';

class chatDetailsScreen extends StatefulWidget {

  final friendName;
  final friendUid;

  const chatDetailsScreen({Key? key, this.friendName, this.friendUid}) : super(key: key);



  @override
  _chatDetailsScreenState createState() => _chatDetailsScreenState(friendName,friendUid);
}

class _chatDetailsScreenState extends State<chatDetailsScreen> {

  final friendName;
  final friendUid;
  CollectionReference chats=FirebaseFirestore.instance.collection('chats');
  final currentUser=FirebaseAuth.instance.currentUser.uid;
  var chatDocID;
  var messageController=TextEditingController();



  @override
  void initState()  {
    // TODO: implement initState
     super.initState();
     chats.where('users',isEqualTo: {friendUid:null,currentUser:null})
        .limit(1)
        .get().
    then(
        (QuerySnapshot querySnapsots)
            {
              if(querySnapsots.docs.isNotEmpty)
                {
                  chatDocID=querySnapsots.docs.single.id;
                }
              else
                {
                 chats.add({
                   'users':{currentUser:null,friendUid:null}
                 }).then((value) {
                   chatDocID=value;
                 });
                }
            }
    ).catchError((error) {});
  }

  bool isSender(String friend)
  {
    return friend==currentUser;
  }

  Alignment getAlignment(String friend)
  {
    if(friend==currentUser)
      return Alignment.topRight;
    else
      return Alignment.topLeft;
  }

  void sendmessage(String msg)
  {
    if(msg=='') return;

    chats.doc(chatDocID).collection('messages').add({
      'createdOn':FieldValue.serverTimestamp(),
      'uid':currentUser,
      'msg':msg
    }).then((value) {
      messageController.text='';
    });

  }

  _chatDetailsScreenState(this.friendName, this.friendUid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,


        title: Text(friendName,style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black
        ),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.local_phone,color: Colors.black,),
          ),
        ],
        elevation: 3,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: StreamBuilder(

        stream: FirebaseFirestore.instance.collection('chats')
            .doc(chatDocID).collection('messages').orderBy('createdOn',descending: true).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          var data=DocumentSnapshot;
          if(snapshot.hasError)
            return Center(
              child: Text('Something wend wrong!'),
            );
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if(snapshot.hasData)
            {
              //initState();
              var data;
              return SafeArea(child: Column(
                children: [
                  Expanded(child: ListView(
                    reverse: true,
                    children: snapshot.data!.docs.map(
                            (DocumentSnapshot document)
                        {
                          data=document.data()!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChatBubble(
                            clipper: ChatBubbleClipper7(


                              radius: 0,
                              type: isSender(data['uid'].toString())?BubbleType.sendBubble:BubbleType.receiverBubble
                            ),
                            alignment: getAlignment(data['uid'].toString()),
                            margin: EdgeInsets.only(top: 20),
                            backGroundColor: isSender(data['uid'].toString())?Colors.blue:Colors.green,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(data['msg'].toString(),style: TextStyle(
                                          color: isSender(data['uid'].toString())?Colors.white:Colors.black),
                                        maxLines: 100,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(data['createdOn']==null?
                                      DateTime.now().toString():
                                      (data['createdOn'] as Timestamp).toDate().toString(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isSender(data['uid'].toString())?Colors.white:Colors.black)

                                        ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
              }).toList()
                    ,
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),

                              ),
                              hintText: 'Send a message...',
                              fillColor: Colors.white70,
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.black
                              )
                            ),

                          ),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          alignment: AlignmentDirectional.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(onPressed: (){
                              sendmessage(messageController.text);

                            }, icon: Icon(Icons.send,color: Colors.blue,)))
                      ],
                    ),
                  )
                ],
              ));
            }
          return Container();
        },
      ),
    );
  }
}
