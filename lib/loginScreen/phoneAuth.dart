import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic/loginScreen/phoneCountry.dart';
import 'package:sonic/loginScreen/verifyNumber.dart';

class phoneAuth extends StatefulWidget {
  @override
  _phoneAuthState createState() => _phoneAuthState();
}

class _phoneAuthState extends State<phoneAuth> {


  var numberController=TextEditingController();
  Map<String,dynamic> data={"name":"Iraq","dial_code":"+964"};
  Map<String,dynamic> dataRetrived={};

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25,bottom: 10),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(Colors.white24, BlendMode.darken),
                            image: AssetImage('images/sonic.png')
                        )
                    ),
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async{

                      dataRetrived=await Navigator.push(context, MaterialPageRoute(builder: (context)=>phoneCountry()));

                      setState(() {
                        if(dataRetrived!=null)
                          data=dataRetrived;
                      });
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.blue,width: 2),
                          color: Colors.white
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            children: [
                              Text(data['name'],style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,color: Colors.blue
                              ),),
                              Icon(Icons.arrow_right,color: Colors.blue,)
                            ],
                          ),
                        )
                      ),
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(data['dial_code'],style: TextStyle(
                      fontSize: 22
                    ),),
                    SizedBox(width: 8,),
                    Expanded(child: TextFormField(
                      style: TextStyle(fontSize: 22,letterSpacing: 1.5),
                      keyboardType: TextInputType.number,
                      controller: numberController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Number',


                      ),
                    ),)

                  ],
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: Text('You Will Receive the Acivation Code in short time.',style: TextStyle(
                  color: Colors.white
                ),),
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)
                    ),
                    color: Colors.blue
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>phoneAuth()));
                  },
                  child:Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>verifyNumber(number: data['dial_code']+numberController.text,)));
                              },
                              child: Text('Request Code',style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                              ),),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text('You Will Receive The Activation Code In a Short Time.',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),)
                    ],
                  )
                ),

              ),






            ],
          ),
        ),
      ),
    ));
  }
}
