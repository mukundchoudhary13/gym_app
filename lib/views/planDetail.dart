import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanDetail extends StatelessWidget {
  PlanDetail({Key? key,required this.doc}) : super(key: key);
  Map<String,dynamic> doc;

  List<String> aa = ["sdfsd","ajdjas"];


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
                  },)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
