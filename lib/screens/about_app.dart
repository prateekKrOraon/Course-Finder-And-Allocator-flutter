import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class AboutApp extends StatefulWidget{
  @override
  _AboutAppState createState() {
    return _AboutAppState();
  }
}

class _AboutAppState extends State<AboutApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,top: 30.0,right: 10.0,bottom: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                "Course Finder",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 100.0,
                  fontFamily: 'Stalemate',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Appplication',
                        style: TextStyle(
                          fontFamily: kQuicksand,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AboutTile(
                        icon: AntDesign.infocirlceo,
                        header: 'Version',
                        text: '0.8.0 - beta',
                      ),
                      AboutTile(
                        icon: AntDesign.unknowfile1,
                        header: 'License',
                        text: 'Open',
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Author',
                        style: TextStyle(
                          fontFamily: kQuicksand,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AboutTile(
                        icon: Icons.person_outline,
                        header: 'Prateek Kumar Oraon',
                        text: 'India',
                      ),
                      GestureDetector(
                        child: AboutTile(
                          icon: SimpleLineIcons.social_github,
                          header: 'GitHub',
                          text: '@prateekKrOraon',
                        ),
                        onTap: (){
                          //TODO: link to github
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}