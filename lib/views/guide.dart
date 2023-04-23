import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  // insert image and their title here
  List<String> text =["100g Oats"];
  List<String> imagepath= ["assets/oats.jpg"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: text.length,
          itemBuilder: (context, index) => Container(

            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(10.0),
              child: ClipRect(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                Image.asset(
                    imagepath[index],

                  fit: BoxFit.fitWidth,

                ),
                Text(text[index])
            ],),
              ),)),),
      ),
    );
  }
}
