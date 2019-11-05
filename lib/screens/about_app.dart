import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: kQuicksand,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,top: 30.0,right: 10.0,bottom: 10.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.school,
                            size: 50.0,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 20.0,),
                          Text(
                            "Course Finder",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50.0,
                              fontFamily: 'Stalemate',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
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
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Place',
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
                        icon: MaterialCommunityIcons.city_variant_outline,
                        header: 'National Institute of Technology Sikkim',
                        text: 'India',
                      ),
                      GestureDetector(
                        child: AboutTile(
                          icon: SimpleLineIcons.location_pin,
                          header: 'Ravangla, South Sikkim',
                          text: 'Sikkim - 737139',
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