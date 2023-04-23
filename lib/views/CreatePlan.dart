import 'package:flutter/material.dart';

import '../Constants/constant.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  String name = '';
  int? height;
  int? weight;
  String calories = '';
  String gender = '';
  int? bmi;
  int? duration;
  int? age;

  String? NameErrorMessage;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text("Fitness Plan")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Create Plan',
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 600,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Create Plan'),
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
                                      weight = value! as int?;
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
                                      height = value! as int?;
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
                                      calories = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
