import 'dart:math';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gym_app/views/SideDrawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sklite/neural_network/neural_network.dart';
import 'package:sklite/utils/io.dart';
import 'dart:convert';

import '../Constants/StandardScalar.dart';



class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  DateTime? selectedDate;
  Random random = new Random();

  User  currentuser = FirebaseAuth.instance.currentUser!;

  var timelineCollection = Hive.box('timeline');

  MLPClassifier ?mExercise;
  MLPClassifier ?mSet;
  
  String exercisePredict = "";





  Future<void> putdata()async{

    String selectedDateStr =selectedDate!.toIso8601String().split("T").first;
    await timelineCollection.put(
        selectedDateStr,{
      'breakfast':breakfastitem,
      'lunch':lunchitem,
      'snack':snackitem,
      'dinner':dinneritem,
      'intakeCal':calIntake
    });





    print(timelineCollection.get(selectedDateStr));

    print(timelineCollection.keys);
  }


  List<String> events=["Breakfast","Lunch","Snack","Dinner"] ;


  int totalCal = 0;
  int calIntake =0;


  List<String> morningFood = [
    "oatmeal 100g Cal:150",
    "poha 100g + Chai Cal:100",
    "6 egg whites Cal:100",
    "Apple + 1 scoop whey protein Cal:150"
  ];

  List<String> lunch = [
    "100g soya + 100g rice Cal:250",
    "100g chicken +100g rice Cal:300",
    "100g fish + 100g rice/ 5 rotis Cal:200"
  ];



  List<String>  snack = [
    "oatmeal 100g Cal:150",
    "poha 100g + Chai Cal:100",
    "6 egg whites Cal:100",
    "Apple + 1 scoop whey protein Cal:150"

  ];

  List<String> dinner = [
    "100g soya + 100g rice Cal:250",
    "100g chicken +100g rice Cal:300",
    "100g fish + 100g rice/ 5 rotis Cal:200"
  ];


  late Map<int,List<String>> fooditems = {
    0:morningFood,
    1:lunch,
    2:snack,
    3:dinner

  };

  List<String> mondayWorkOut = [
    "BACK",
    "Lat pull down:- 10-12(3sets)",
    "One arm row:-10(3sets)",
    "Seated row:-10(3sets)"
  ];
  List<String> tuesdayWorkOut = [
    "LEGS",
    "Free Squats-100 (3sets)",
    "weighted squats:60(2 sets)",
    "Leg Press: 12-15(3sets)",
    "Leg Curl: 12-15(3sets)"
  ];
  List<String> wednesdayWorkOut = [
    "CHEST",
    "Pushups 10-12(3sets)",
    "Flat Dumbbell chest press:-15(3sets)",
    "Incline dumbbell chest fly:- 8-10(3sets)",
    "Chest Machine fly:- 10-12(3sets)"
  ];
  List<String> thursdayWorkOut = [
    " BICEPS",
    "Dumbbell Biceps normal:- 8-12(3sets)",
    "Incline Dumbbell Biceps" "Bench:-8-10(3sets)",
    "Rod Curls:-10(3sets)",
    "Cable biceps:- 8-12(2sets)"
  ];
  List<String> fridayWorkOut = [
    "SHOULDERS",
    "Seated Dumbbell Press:- 15(3sets)",
    "Upright Row:- 10(4sets)",
    "Lateral Raises:- 15(3sets)"
  ];
  List<String> saturdayWorkOut = [
    "TRICEPS",
    "Bent-Over Dumbbell Triceps", "Kickback:- 10-12(2sets)",
    "Dumbbell Overhead Triceps:-, 15(3sets)",
    "Triceps Dips:- 15(3sets)",
    "Triceps pushdown Cable:- 15(3sets)"
  ];
  List<String> sundayWorkOut = [
    "Total Rest",
  ];


  late Map<int,List<String>> workoutdays ={
    1:mondayWorkOut,
    2:tuesdayWorkOut,
    3:wednesdayWorkOut,
    4:thursdayWorkOut,
    5:fridayWorkOut,
    6:saturdayWorkOut,
    7:sundayWorkOut
  };






  List<String> breakfastitem = [];
  List<String> lunchitem = [];
  List<String> snackitem = [];
  List<String> dinneritem = [];

  late Map<int,List<String>> eventFood = {
    0:breakfastitem,
    1:lunchitem,
    2:snackitem,
    3:dinneritem

  };
  load() async {
    await loadModel("assets/fitness.json").then((x) {
      mExercise = MLPClassifier.fromMap(json.decode(x));
    });

    await loadModel("assets/fitnessSet.json").then((x) {
      mSet = MLPClassifier.fromMap(json.decode(x));
    });

  }



  Map<int,String> ExerciseData ={
    0: '50 Free Squats ',
    1:'10 weighted squats',
    2:'Leg Press',
    3:'Leg Curl',
    4:'SHOULDERS',
    5:'Seated Dumbbell Press',
    6:'Upright Row',
    7:'Lateral Raises',
    8:'Squats',
    9:'Pushups',
    10:'Flat Dumbbell chest press',
    11:'Incline dumbbell chest fly',
    12:'Chest Machine fly',
    13:'25 Pushups',
    14:'Bent-Over Dumbbell Triceps Kickback',
    15:'Dumbbell Overhead Triceps',
    16: 'Triceps Dips',
    17: 'Triceps pushdown Cable',
    18:'Free Squats',
    19:'Weighted Squats',
    20:'Flat Dumbbell Chest Press',
    21:'Incline Dumbbell Chest Fly',
    22:'Chest Machine Fly',
    23:'Triceps Pushdown Cable'
  };


  void timeLine(){
   final timeLineCard= timelineCollection.get(currentuser.uid);
    if(timeLineCard !=null){

      List<String> breakfastitt = timeLineCard["breakfast"];
      List<String> lunchitt = timeLineCard["lunch"];
      List<String> snackitt = timeLineCard["snack"];
      List<String> dinneritt = timeLineCard["dinner"];

      DateTime validation = timeLineCard["valid"];

     int total_cal = timeLineCard["total_calories"];

      if(validation.isBefore(DateTime.now()) ==false){
        fooditems.update(0, (value) => breakfastitt);
        fooditems.update(1, (value) => lunchitt);
        fooditems.update(2, (value) => snackitt);
        fooditems.update(3, (value) => dinneritt);

        totalCal = total_cal;
      }
      else{
        fooditems.update(0, (value) => []);
        fooditems.update(1, (value) => []);
        fooditems.update(2, (value) => []);
        fooditems.update(3, (value) => []);
        totalCal =0;
      }
      setState(() {

      });


    }else{
      setState(() {

      fooditems.update(0, (value) => []);
      fooditems.update(1, (value) => []);
      fooditems.update(2, (value) => []);
      fooditems.update(3, (value) => []);

      });
    }
  }




  @override
  void initState() {
    timeLine();
    load();
    setState(() {
      selectedDate = DateTime.now();
      var timeLineItem=  timelineCollection.get(selectedDate!.toIso8601String().split("T").first);
      // print(timeLineItem["breakfast"]. );

      if(timeLineItem !=null) {
        print("inso");
        print(timeLineItem["breakfast"] );

        List<String> breakfastitt = timeLineItem["breakfast"];
        List<String> lunchitt = timeLineItem["lunch"];
        List<String> snackitt = timeLineItem["snack"];
        List<String> dinneritt = timeLineItem["dinner"];
        int intakeCal =timeLineItem["intakeCal"];
        print("breakfastitt");
        print(breakfastitt);

        breakfastitem = [];
        lunchitem=[];
        snackitem=[];
        dinneritem=[];

        calIntake = intakeCal;


        breakfastitem.addAll(breakfastitt);
        lunchitem.addAll(lunchitt);
        snackitem.addAll(snackitt);
        dinneritem.addAll(dinneritt);

        eventFood.update(0, (value) => breakfastitem);
        eventFood.update(1, (value) => lunchitem);
        eventFood.update(2, (value) => snackitem);
        eventFood.update(3, (value) => dinneritem);
      }
    });

    super.initState();
  }




  String predict(double cal){


    StandardScaler standardScaler = StandardScaler();

    List<List<double>> X = [[0.0, 19.0, 13.0, 26.0],
      [1.0, 24.0, 64.0, 23.0],
      [0.0, 30.0, 84.0, 22.0],
      [0.0, 31.0, 48.0, 38.0],
      [1.0, 20.0, 33.0, 18.0],
      [0.0, 29.0, 79.0, 25.0],
      [0.0, 26.0, 185.0, 30.0],
      [0.0, 22.0, 26.0, 18.0],
      [0.0, 24.0, 35.0, 25.0],
      [0.0, 19.0, 145.0, 22.0],
      [1.0, 27.0, 88.0, 27.0],
      [0.0, 22.0, 171.0, 19.0],
      [0.0, 20.0, 27.0, 23.0],
      [1.0, 23.0, 150.0, 27.0],
      [1.0, 25.0, 130.0, 28.0],
      [0.0, 28.0, 113.0, 29.0],
      [0.0, 25.0, 141.0, 25.0],
      [1.0, 29.0, 170.0, 30.0],
      [0.0, 31.0, 95.0, 21.0],
      [1.0, 22.0, 161.0, 27.0],
      [0.0, 30.0, 24.0, 28.0],
      [1.0, 25.0, 12.0, 42.0],
      [1.0, 23.0, 189.0, 25.0],
      [0.0, 30.0, 67.0, 29.0],
      [1.0, 25.0, 182.0, 22.0],
      [0.0, 25.0, 113.0, 22.0],
      [0.0, 25.0, 71.0, 30.0],
      [1.0, 30.0, 54.0, 25.0],
      [0.0, 30.0, 139.0, 40.0],
      [1.0, 28.0, 149.0, 22.0],
      [1.0, 22.0, 123.0, 26.0],
      [0.0, 25.0, 84.0, 26.0],
      [1.0, 21.0, 191.0, 26.0],
      [1.0, 26.0, 196.0, 19.0],
      [1.0, 24.0, 64.0, 19.0],
      [1.0, 18.5, 36.0, 35.0],
      [0.0, 28.0, 88.0, 22.0],
      [1.0, 30.0, 110.0, 24.0],
      [1.0, 26.0, 70.0, 21.0],
      [1.0, 22.0, 114.0, 18.0],
      [1.0, 27.0, 69.0, 18.0],
      [1.0, 21.0, 75.0, 18.0],
      [1.0, 30.0, 54.0, 30.0],
      [0.0, 26.0, 23.0, 22.0],
      [0.0, 30.0, 100.0, 18.0],
      [0.0, 22.0, 21.0, 29.0],
      [0.0, 21.0, 116.0, 27.0],
      [0.0, 25.0, 164.0, 24.0],
      [1.0, 22.0, 47.0, 22.0],
      [0.0, 24.0, 109.0, 20.0],
      [1.0, 24.0, 147.0, 19.0],
      [1.0, 20.0, 42.0, 29.0],
      [0.0, 30.0, 187.0, 26.0],
      [0.0, 29.0, 140.0, 26.0],
      [1.0, 28.0, 23.0, 23.0],
      [1.0, 24.0, 38.0, 20.0],
      [0.0, 19.0, 188.0, 25.0],
      [1.0, 22.0, 24.0, 22.0],
      [1.0, 20.0, 84.0, 26.0],
      [0.0, 30.0, 177.0, 20.0],
      [0.0, 25.0, 166.0, 20.0],
      [1.0, 22.0, 144.0, 18.0],
      [0.0, 22.0, 84.0, 18.0],
      [1.0, 18.5, 18.0, 30.0],
      [0.0, 24.0, 80.0, 29.0],
      [1.0, 19.0, 39.0, 29.0],
      [1.0, 21.0, 91.0, 28.0],
      [1.0, 25.0, 134.0, 25.0],
      [0.0, 23.0, 176.0, 23.0],
      [1.0, 22.0, 140.0, 24.0],
      [1.0, 19.0, 153.0, 20.0],
      [0.0, 20.0, 32.0, 18.0],
      [0.0, 21.0, 159.0, 30.0],
      [1.0, 22.0, 175.0, 30.0],
      [1.0, 26.0, 111.0, 19.0],
      [1.0, 19.0, 167.0, 30.0],
      [0.0, 30.0, 96.0, 29.0],
      [1.0, 29.0, 22.0, 19.0],
      [0.0, 30.0, 104.0, 21.0]];
    standardScaler.fit_transform(X);
    // print();

    // print(standardScaler.mean_);






    // print(mExercise.predict([0,	22	,10,	20]));
    // print(mSet.predict([0,	22	,10,	20]));

    print(cal);


   final scale = standardScaler.transform([[1,26,cal,22]]).first;

setState(() {
    exercisePredict =  ExerciseData[mExercise!.predict(scale)]! + " " + mSet!.predict(scale).toString() + " Sets";
  
});

return exercisePredict;
   

  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: SideDrawer(),
        appBar: CalendarAppBar(

          onDateChanged: (value) async {
            setState(()  {
              selectedDate = value;
            });
            print("changed");
            print(selectedDate!.toIso8601String().split("T").first);

            var timeLineItem= await  timelineCollection.get(selectedDate!.toIso8601String().split("T").first);
            // print(timeLineItem["breakfast"]. );

            if(timeLineItem !=null) {
              print("inso");
              print(timeLineItem["breakfast"] );

              List<String> breakfastitt = timeLineItem["breakfast"];
              List<String> lunchitt = timeLineItem["lunch"];
              List<String> snackitt = timeLineItem["snack"];
              List<String> dinneritt = timeLineItem["dinner"];
              int intakeCal =timeLineItem["intakeCal"];

              print("breakfastitt");
              print(breakfastitt);

              breakfastitem = [];
              lunchitem=[];
              snackitem=[];
              dinneritem=[];


              calIntake=intakeCal;



              breakfastitem.addAll(breakfastitt);
              lunchitem.addAll(lunchitt);
              snackitem.addAll(snackitt);
              dinneritem.addAll(dinneritt);

              eventFood.update(0, (value) => breakfastitem);
              eventFood.update(1, (value) => lunchitem);
              eventFood.update(2, (value) => snackitem);
              eventFood.update(3, (value) => dinneritem);


              print("breakfastitem");
              print(breakfastitem);

              setState(() {

              });
            }else{
              print("yoo");
              eventFood.update(0, (value) => []);
              eventFood.update(1, (value) => []);
              eventFood.update(2, (value) => []);
              eventFood.update(3, (value) => []);

              calIntake=0;

              setState(() {
                breakfastitem = [];
                lunchitem=[];
                snackitem=[];
                dinneritem=[];

              });
            }


          },
          lastDate: DateTime.now(),
          events: List.generate(
              100,
                  (index) => DateTime.now()
                  .subtract(Duration(days: index * random.nextInt(5)))),
          backButton: true,




        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: AbsorbPointer(
            absorbing: selectedDate!.day.compareTo(DateTime.now().day)==0 ? false : true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Center(
                  child: Card(
                    child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text("Total Calories"),
                            Text("$calIntake"+"/"+"$totalCal")
                          ],
                        )),
                  ),
                ),
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(

                                title: Text(events[index]),
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(


                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Expanded(child: fooditems[index]!.isEmpty ? Center(child: Image.asset('assets/png.png')):ListView(children: fooditems[index]!.map((e) => Card(
                                                child : ListTile(title: Text(e),
                                                  onTap: ()async{
                                                    switch(index){
                                                      case 0:
                                                        String cal = e.split(':').last;

                                                        calIntake += int.parse(cal);
                                                        breakfastitem.add(e);



                                                        break;
                                                      case 1:
                                                        String cal = e.split(":").last;
                                                        calIntake += int.parse(cal);
                                                        lunchitem.add(e);
                                                        break;
                                                      case 2:
                                                        String cal = e.split(":").last;
                                                        calIntake += int.parse(cal);
                                                        snackitem.add(e);
                                                        break;
                                                      case 3:
                                                        String cal = e.split(":").last;
                                                        calIntake += int.parse(cal);
                                                        dinneritem.add(e);
                                                        break;
                                                    }
                                                    await putdata();
                                                    setState(()  {
                                                      eventFood.update(0, (value) => breakfastitem);
                                                      eventFood.update(1, (value) => lunchitem);
                                                      eventFood.update(2, (value) => snackitem);
                                                      eventFood.update(3, (value) => dinneritem);

                                                    });
                                                    Navigator.pop(context);
                                                  },

                                                ),
                                              ),).toList(),
                                              ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },

                              ),
                              ListView.builder(

                                itemBuilder: (context, indexx) {
                                  final item =  eventFood[index]![indexx];

                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      color: Colors.red,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                        child: Icon(Icons.delete,
                                          color: Colors.white,

                                        ),


                                      ),
                                    ),
                                    onDismissed: (direction) {

                                      setState(() {
                                      String cal = eventFood[index]![indexx].split(':').last;
                                      int remCal = int.parse(cal);
                                      calIntake -= remCal;

                                      eventFood[index]!.removeAt(indexx);


                                      putdata();
                                      });
                                    },
                                    key: UniqueKey(),
                                    child: ListTile(
                                        title:Text(eventFood[index]![indexx]),



                                    ),
                                  );
                                },
                                itemCount: eventFood[index]!.length,

                                // eventFood[index]!.map((e) =>Text(e) ).toList(),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              )
                            ],
                          ),
                        );
                      },),

                  ],
                ),

                SizedBox(height: 20,),

                Text("Workout"),


                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: workoutdays[selectedDate!.weekday]!.map((e) {
                    return Column(
                      children: [
                        Text(e),

                      ],
                    );
                  }).toList(),),
                if(calIntake > totalCal)...[


Text(predict((calIntake - totalCal ).toDouble()))

                 
                ]


              ],
            ),
          ),
        )
    );
  }
}