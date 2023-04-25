import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() {
  runApp(pedometer());
}

class pedometer extends StatefulWidget {
  @override
  _pedometerState createState() => _pedometerState();
}

class _pedometerState extends State<pedometer> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back),),
          centerTitle: true, // <--- Center the title
          title: const Text('Pedometer'),

        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'DAILY GOAL 1000',
                  style: TextStyle(fontSize: 15),
                ),


                Text(
                  'Steps taken:',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  _steps,
                  style: TextStyle(fontSize: 60),
                ),
                Divider(
                  height: 100,
                  thickness: 0,
                  color: Colors.white,
                ),
                Text(
                  'Pedestrian status:',
                  style: TextStyle(fontSize: 30),
                ),

                Icon(
                  _status == 'walking'
                      ? Icons.directions_walk
                      : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
                  size: 100,
                ),
                Center(
                  child: Text(
                    _status,
                    style: _status == 'walking' || _status == 'stopped'
                        ? TextStyle(fontSize: 30)
                        : TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),



                ListTile(

              title: Text("How many calories do you burn from 10,000 steps?"),

                  subtitle: Column(

                    children: [
                      Card(
                        elevation: 4,
                        margin: EdgeInsets.all(10.0),
                        child: ClipRect(
                          clipBehavior: Clip.antiAlias,
                          child: Column(children: [
                            Image.asset(
                              "assets/stepsdata.png",

                              fit: BoxFit.fitWidth,

                            ),

                          ],),
                        ),),
                      Text
                        ( "Any estimation of how many calories you burn from an exercise like walking or running depends on how heavy you are. On average, heavier people use more energy to move than lighter people. Most rough estimates revolve around 100 calories burned per mile for a 180-pound person."
                      ),
                      Text("How many miles are 10,000 steps? On average, 10,000 steps are going to come out to be roughly 5 miles. So assuming you weigh 180 pounds, then yes, by simple mathematics, 100 calories x 5 miles equals 500 calories. Over a week, that becomes 3,500 calories."),
                      Text("But if you are lighter or heavier, you will burn less/more calories while taking the same number of steps or walking the same distance."),
                    ],
                  ),

      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

