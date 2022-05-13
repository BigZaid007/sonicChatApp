import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sonic/loginScreen/userName.dart';

enum Status { Waiting, Error }

class verifyNumber extends StatefulWidget {
  final number;

  const verifyNumber({Key? key, this.number}) : super(key: key);
  @override
  _verifyNumberState createState() => _verifyNumberState(number);
}

class _verifyNumberState extends State<verifyNumber> {
  final phoneNumber;

  var _status = Status.Waiting;
  var _verficationID;
  var controller = TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  _verifyNumberState(this.phoneNumber);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneAuthverify();
  }

  Future _phoneAuthverify() async
  {
    _auth.verifyPhoneNumber(phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential) async {},
        verificationFailed: (PhoneVerificationFailed)async {},
        codeSent: (verficationID,resendingToked) async {
      setState(() {
        this._verficationID=verficationID;
      });
        },
        codeAutoRetrievalTimeout: (verficationID) async {});
  }

  Future _sendCodetoFirebase({String? code}) async {
    if(_verficationID!=null)
      {
        var credential=PhoneAuthProvider.credential(verificationId: _verficationID, smsCode: code);
        _auth.signInWithCredential(credential)
            .then((value)  {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>userName()));
        })
            .whenComplete(() {})
            .onError((error, stackTrace) {
              setState(() {
                controller.text="";
                _status=Status.Error;

              });
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue,),
            ),
          ),

      body: Container(
        child: _status != Status.Error
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                          fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text('Enter OTP sent to $phoneNumber'),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      onChanged: (value){
                        if(value.length==6)
                          _sendCodetoFirebase(code: value);

                      },
                      //maxLength: 6,

                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 45,

                      ),
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Did\'t get the OTP?',style: TextStyle(
                        fontSize: 16
                      ),),
                      SizedBox(width: 3,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            this._status=Status.Waiting;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Resend Code',style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue
                        ),),
                      )
                    ],
                  )

                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                          fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'The Code You Entered is Invalid',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Edit Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        this._status=Status.Waiting;
                      });
                      await _phoneAuthverify();
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue),
                      child: Text(
                        'Resend the code',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    ));
  }
}
