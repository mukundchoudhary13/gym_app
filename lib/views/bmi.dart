import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gym_app/views/timeline.dart';


class BmiPage extends StatefulWidget {
  BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {


  int height =140;
  int weight = 80;
  String gender ="";
  String bmi="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(

            children:[
              Text(
                'HEIGHT',

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    height.toString(),

                  ),
                  Text(
                    'cm',

                  ),],),
              Slider(
                value: height.toDouble(),
                min: 130,
                max: 220,
                onChanged: (double newValue) {
                  setState(() {
                    height = newValue.round();
                  });
                },
              ),

              Text(
                'WEIGHT',

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    weight.toString(),

                  ),
                  Text(
                    'kg',

                  ),],),
              Slider(
                value: weight.toDouble(),
                min: 30,
                max: 220,
                onChanged: (double newValue) {
                  setState(() {
                    weight = newValue.round();
                  });
                },
              ),


              RadioListTile(
                title: Text("Male"),
                value: "male",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),

              RadioListTile(
                title: Text("Female"),
                value: "female",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),



              ElevatedButton(onPressed: (){
                Calculate cal = Calculate(height: height, weight: weight);
                bmi = cal.result();
                setState(() {

                });

              }, child: Text("Calculate")),
              Text("BMI"),
              Text(bmi),

            ],

          ),
        )
    );
  }
}




class Calculate {
  Calculate({required this.height, required this.weight});
  final int height;
  final int weight;
  double _bmi = 0;
  Color _textColor = Color(0xFF24D876);
  String result() {
    _bmi = (weight / pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getText() {
    if (_bmi >= 25) {
      return 'OVERWEIGHT';
    } else if (_bmi > 18.5) {
      return 'NORMAL';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  String getAdvise() {
    if (_bmi >= 25) {
      return 'You have a more than normal body weight.\n Try to do more Exercise';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight.\nGood job!';
    } else {
      return 'You have a lower than normal body weight.\n Try to eat more';
    }
  }

  Color getTextColor() {
    if (_bmi >= 25 || _bmi <= 18.5) {
      return Colors.deepOrangeAccent;
    } else {
      return Color(0xFF24D876);
    }
  }
}
