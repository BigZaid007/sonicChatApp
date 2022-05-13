import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sonic/loginScreen/phoneAuth.dart';

class hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.white24, BlendMode.darken),
                      image: AssetImage('images/sonic.png')
                    )
                  ),
                ),
                Text('Welcome To Sonic',style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Colors.blue
                ),),
                SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Sonic is a chat app that help you to connect with your friends from all over the world.',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black54

                  ),),
                ),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>phoneAuth()));
                  },
                  child: Text('Terms and Conditaions',style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                  ),),
                ),
                SizedBox(height: 50,),
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
                    child: Center(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        width: 140,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Text('Get Started',style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                  ),

                ),



              ],
            ),
          ),
        ),
      ),
    ));
  }
}
