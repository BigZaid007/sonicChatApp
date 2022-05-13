
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sonic/loginScreen/phoneAuth.dart';

class phoneCountry extends StatefulWidget {
  @override
  _phoneCountryState createState() => _phoneCountryState();
}



class _phoneCountryState extends State<phoneCountry> {

  var _searchController=TextEditingController();
  var searchValue='';
  List<dynamic>? dataRetrived;
  List<dynamic>? data;

  @override
  void initState(){
    _getData();
  }

  Future _getData() async
  {
    final String response=await rootBundle.loadString('assets/CountryCodes.json');
    dataRetrived=await json.decode(response) as List<dynamic>;
    setState(() {
      data=dataRetrived;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(

              automaticallyImplyLeading: false,
              previousPageTitle: 'Edit Number',
              largeTitle: Text('Select Country'),
            ),
            SliverToBoxAdapter(
              child: CupertinoSearchTextField(
                controller: _searchController,
                onChanged: (value){
                  setState(() {
                    searchValue=value;
                  });
                },
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(
                (data!=null)? data!.where((e) => e['name'].toString().toLowerCase().contains(searchValue.toLowerCase())).map((e) => GestureDetector(
                  onTap: (){
                    print(e['name']);
                    Navigator.pop(context,{"name":e['name'],"dial_code":e['dial_code']});
                  },
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(e['name'],style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),),
                      trailing:Text(e['dial_code'],style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),) ,
                    ),
                  ),
                )).toList():[Center(
                  child: Text('Loading'),
                )]
            )
            )
          ],
        )


      ),
    );
  }
}
