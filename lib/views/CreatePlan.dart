import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/Services/Firebase/database_functions.dart';

import 'package:gym_app/views/bmi.dart';
import 'package:gym_app/views/planDetail.dart';

import '../Constants/constant.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  late User  currentuser = FirebaseAuth.instance.currentUser!;

  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    // TODO: implement initState
    _usersStream= FirebaseFirestore.instance.collection('calories').doc(currentuser.uid).collection('plan').snapshots();

    super.initState();
  }

  String name = '';
  int? height;
  int? weight;
  int? calories ;
  String gender = '';
  int? bmi;
  int? duration;
  int? age;
  String? id;

  String? NameErrorMessage;

  TextEditingController bmiController = TextEditingController();

  final _formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [Text("Fitness Plan"),


              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if(snapshot.hasData){
                    if(snapshot.data!.size >0){

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          final data =  snapshot.data!.docs;

                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(data[index]['pending']==false){
                                  final dat = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlanDetail(doc: dat),));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index]['id'].toString(),style: TextStyle(fontSize: 25),),
                                    if(data[index]['pending'])...[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.pending_actions),
                                          Text("Pending")
                                        ],
                                      ),
                                    ]else...[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,

                                        children: [
                                          Icon(Icons.done_outlined,color: Colors.green,),
                                          Text("Ready")
                                        ],
                                      ),
                                    ]

                                  ],
                                ),
                              ),
                            ),

                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                      );
                    }
                    else{
                      return Column(
                        children: [
                          SizedBox(height: 150,),
                          Image.asset('assets/png.png'),
                        ],
                      );
                    }
                  }
                  return SizedBox();
                },
              )






            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Create Plan',
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                height: _height-80,
                child: Column(

                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Create Plan',style: TextStyle(fontSize: 25),),
                      Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('id'),
                                decoration: InputDecoration(
                                  labelText: "Plan name",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    id = value!;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('name'),
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    name = value!;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('age'),
                                decoration: InputDecoration(
                                  labelText: "age",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    age = int.parse(value!);
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('weight'),
                                decoration: InputDecoration(
                                  labelText: "Weight",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    weight = int.parse(value!);
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('height'),
                                decoration: InputDecoration(
                                  labelText: "Height",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },

                                onSaved: (value) {
                                  setState(() {
                                    height = int.parse(value!);


                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(

                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('bmi'),
                                decoration: InputDecoration(
                                  labelText: "Bmi",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    bmi = int.parse(value!);
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('calories'),
                                decoration: InputDecoration(
                                  labelText: "Calories",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    calories = int.parse(value!);
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey('duration'),
                                decoration: InputDecoration(
                                  labelText: "Duration",
                                  border: OutlineInputBorder()
                                  ,

                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    duration = int.parse(value!);
                                  });
                                },
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                width: 400,
                                child: ElevatedButton(onPressed: ()async{

                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();


                                    await Database().createBasicInfo("calories", currentuser!.uid, name, age!, weight!, height!, bmi!, duration!,id!,calories!);
                                    Navigator.pop(context);
                                  }
                                }, child: Text("Submit")))
                          ],
                        ),
                      ),
                    ]),
              );
            },
          );
        },
      ),
    );
  }
}
