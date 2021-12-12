import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class contactlist extends StatefulWidget {
  const contactlist({Key? key}) : super(key: key);

  @override
  _contactlistState createState() => _contactlistState();
}

class _contactlistState extends State<contactlist> {
 late List _readyData;
 late List _unfiltered;

 Future<String> loadjsondata() async {
   var jsonText = await rootBundle.loadString("assets/Data.json");

   setState(() {
     _readyData = jsonDecode(jsonText);
   });
   this._unfiltered = _readyData;
   return "got the data";
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadjsondata();
  }
 searchBar (str) {
   var srtingExist = str.length > 0 ? true : false;

   if (srtingExist){
     var filtered = [];

         for (int i=0; i< _unfiltered.length; i++){
           String name = _unfiltered[i]["Name"]. toUpperCase();
           if (name.contains(str.toUpperCase())){
             filtered.add(_unfiltered[i]);
           }
           setState(() {
             this._readyData = filtered;
           });
         }
   }
   else {
     setState(() {
       this._readyData = _unfiltered;
     });
   }
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("App Bar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (str){
              searchBar(str);
            },
            decoration: InputDecoration(
                hintText: "Search Contact",
                prefixIcon: Icon(Icons.search),

            ),
          ),
          
          Expanded(
            child: ListView.builder(
                itemCount: _readyData.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(_readyData[index]["Name"][0]),
                        ),
                        title: Text(_readyData[index]["Name"]),
                        subtitle: Text(_readyData[index]["Phone"]),
                        onTap: (){
                        },
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    ),);
  }
}
