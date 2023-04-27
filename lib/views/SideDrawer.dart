import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/views/pedometer.dart';
import 'package:gym_app/views/workouttimer.dart';
import '../Services/Firebase/auth_functions.dart';
import '../main.dart';
import 'Credential_Pages/Credential_Pages/signin_page/signin_page.dart';
import 'bmi.dart';
class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key}) : super(key: key);

  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(currentuser!.email!),
            accountName: Text(currentuser!.displayName!),
            currentAccountPicture: currentuser!.photoURL != null ? CircleAvatar(backgroundImage:   NetworkImage(currentuser!.photoURL!)): CircleAvatar(child: Text(currentuser!.email![0].toUpperCase(),style: TextStyle(fontSize:25 ),),),
          ),

          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
            },


          ),

          ListTile(
            title: Text('BMI calculator'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BmiPage()));
              // Update the state of the app.
              // ...
            },
          ),

          ListTile(
            title: Text('Pedometer'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pedometer()));
              // Update the state of the app.
              // ...
            },
          ),

          // ListTile(
          //   title: Text('Workout Timer'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutTimer()));
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),

          // ListTile(
          //   title: Text('Progress Chart'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => progresschart()));
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          //


          ListTile(
            title: Text('About us'),
            onTap: () {
              // Update the state of the app.
              // ...
            },),


          ElevatedButton(onPressed: ()async {
            await Auth().signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Signin(),), (route) => false);
          }, child: Text("Logout"))




        ],
      ),
    );
  }
}
