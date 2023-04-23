import 'dart:math';

import 'package:calendar_appbar/calendar_appbar.dart';

import 'package:flutter/material.dart';
import 'package:gym_app/views/SideDrawer.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  DateTime? selectedDate;
  Random random = new Random();



  var timelineCollection = Hive.box('timeline');





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


  int totalCal = 1000;
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



  @override
  void initState() {
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
                                              Expanded(child: ListView(children: fooditems[index]!.map((e) => Card(
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
                    return Row(
                      children: [
                        Text(e),
                        if(calIntake > totalCal)...[

                          Text("+ "),
                          Text("(2sets)")
                        ]
                      ],
                    );
                  }).toList(),)



              ],
            ),
          ),
        )
    );
  }
}