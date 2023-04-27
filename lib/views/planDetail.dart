import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlanDetail extends StatelessWidget {
  PlanDetail({Key? key,required this.doc}) : super(key: key);
  Map<String,dynamic> doc;

  var timelineCollection = Hive.box('timeline');

   User  currentuser = FirebaseAuth.instance.currentUser!;





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Plan Details"),
                SizedBox(height: 15,),
                // Text(doc["BreakFast"].toString()),

                //
                // ListView(
                //
                // )
                Text("Breakfast"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doc["BreakFast"].length,
                  itemBuilder: (context, index) {
                    return Text(doc["BreakFast"][index].toString());
                  },),
                SizedBox(height: 15,),
                Text("Lunch"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doc["Lunch"].length,
                  itemBuilder: (context, index) {
                    return Text(doc["Lunch"][index].toString());
                  },),
                SizedBox(height: 15,),
                Text("Snack"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doc["Snack"].length,
                  itemBuilder: (context, index) {
                    return Text(doc["Snack"][index].toString());
                  },),
                SizedBox(height: 15,),
                Text("Dinner"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doc["Dinner"].length,
                  itemBuilder: (context, index) {
                    return Text(doc["Dinner"][index].toString());
                  },),

                ElevatedButton(onPressed: ()async{


                  List<String> breakfast=List<String>.from( doc["BreakFast"]);
                  List<String> lunch = List<String>.from(doc["Lunch"]);
                  List<String> snack= List<String>.from(doc["Snack"]);
                  List<String> dinner=List<String>.from( doc["Dinner"]);

                  int cal = doc["total_calories"] as int;


                  await timelineCollection.put(
                      currentuser.uid,{
                    'breakfast':breakfast,
                    'lunch': lunch,
                    'snack': snack,
                    'dinner': dinner,
                    'valid' : DateTime.now().add(Duration(days: doc["duration(days)"] as int)),
                    'total_calories':cal

                  });

                  Navigator.pop(context);
                }, child: Text("Add to timeline"))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
