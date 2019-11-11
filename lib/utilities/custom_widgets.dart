import 'package:course_finder/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'constants.dart';

class InputTextField extends StatelessWidget{

  InputTextField({this.labelText,this.icon,this.onChanged,this.onTap,this.obscureText:false});

  final String labelText;
  final Function onChanged;
  final IconData icon;
  final bool obscureText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          suffixIcon: GestureDetector(onTap:onTap,child: Icon(icon)),
          labelText: labelText,
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2.0,
              )
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget{

  CustomFlatButton({this.text,this.icon,this.onPressed});

  final String text;
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: FlatButton(
        shape: StadiumBorder(
            side: BorderSide(
              color: Theme.of(context).accentColor,
              width: 1.0,
            )
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: Theme.of(context).accentColor,),
              SizedBox(width: 20.0,),
              Text(
                text,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).accentColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class CustomRaisedButton extends StatelessWidget{

  CustomRaisedButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: RaisedButton(
        color: Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30.0,
                color: Theme.of(context).accentColor,
                fontFamily: kQuicksand,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget{

  CustomListTile({this.text,this.header,this.icon});

  final String text;
  final String header;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).accentColor,
            size: 30.0,
          ),
          SizedBox(width: 30.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontFamily: kQuicksand,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontFamily: kQuicksand,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

class TextListTile extends StatelessWidget{

  TextListTile({this.title,this.trailing});
  final String title;
  final String trailing;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontSize: 18.0,
                ),
              ),
              Expanded(
                child: Text(
                  trailing,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: kNotoSansSC,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget{

  BottomSheetButton({this.text,this.onPressed});

  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: kNotoSansSC,
              fontSize: 20.0,
            ),
          ),
          onPressed: onPressed,
        ),
        Divider(color: Theme.of(context).primaryColor,),
      ],
    );
  }

}

// ignore: must_be_immutable
class ResultTile extends StatelessWidget{

  ResultTile({this.courseId,this.collegeId,this.iconLink,this.collegeName,this.courseName='Search Course',this.location,this.showCourse});

  final int collegeId;
  final String collegeName;
  final String location;
  String courseName;
  final String iconLink;
  final int courseId;
  final bool showCourse;

  @override
  Widget build(BuildContext context) {
    if(courseName == null){
      courseName = 'Search COurse';
    }
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.fromLTRB(10.0,10.0,10.0,0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),

                  image: DecorationImage(
                    image: NetworkImage(iconLink),

                  )
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    collegeName,
                    style: TextStyle(
                      fontFamily: kNotoSansSC,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 6.0,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        SimpleLineIcons.location_pin,
                        color: Theme.of(context).accentColor,
                        size: 20.0,
                      ),
                      SizedBox(width: 5.0,),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontFamily: kNotoSansSC,
                            fontSize: 13.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0,),
                  showCourse?Row(
                    children: <Widget>[
                      Icon(
                        AntDesign.edit,
                        color: Theme.of(context).accentColor,
                        size: 20.0,
                      ),
                      SizedBox(width: 5.0,),
                      Expanded(
                        child: Text(
                          courseName,
                          style: TextStyle(
                            fontFamily: kNotoSansSC,
                            fontSize: 13.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ):SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class BackdropButton extends StatelessWidget{

  BackdropButton({this.onTap,this.text,this.icon});
  final String text;
  final Function onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:Container(
        padding: EdgeInsets.symmetric(horizontal:30.0,vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: kQuicksand,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(icon,color: Colors.white,),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

class CourseButton extends StatelessWidget{

  CourseButton({this.onPressed,this.courseDuration,this.cost,this.courseName,this.collegeId,this.courseId});

  final String courseName;
  final String cost;
  final String courseDuration;
  final Function onPressed;
  final int courseId;
  final int collegeId;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                courseName,
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontSize: 25.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "\u20B9 $cost\n$courseDuration",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontSize: 25.0,
                ),
              ),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }

}

class QuickFacts extends StatelessWidget{

  QuickFacts({this.owner,this.totalFaculty,this.type,this.year});
  final String type;
  final String owner;
  final int year;
  final int totalFaculty;
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      AntDesign.filetext1,
                      size: 25.0,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Type',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kQuicksand,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      MaterialCommunityIcons.city_variant_outline,
                      size: 27.0,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ownership',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            owner,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kQuicksand,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height:20.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      AntDesign.clockcircleo,
                      size: 25.0,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Estd. Year',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            year.toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kQuicksand,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 30.0,
                      color: Theme.of(context).accentColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Total Faculty',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            totalFaculty.toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kQuicksand,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class CustomDashboardChips extends StatelessWidget{

  CustomDashboardChips({this.text,this.userId});
  final String text;
  final int userId;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: StadiumBorder(
        side: BorderSide(
          width: 1.0,
          color: Theme.of(context).accentColor,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 10.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: kQuicksand,
            fontSize: 20.0
          ),
        ),
      ),
      onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(screenNumber: 1,searchData: text,userId: userId,)));
      },
    );
  }
}

class CustomDashboardTile extends StatelessWidget{

  CustomDashboardTile({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.grey[400]
      ),
      child: Container(
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.overlay,
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style:TextStyle(
              fontFamily: kQuicksand,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}

class AboutTile extends StatelessWidget{
  AboutTile({this.header,this.icon,this.text});
  final IconData icon;
  final String header;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).accentColor,
            size: 30.0,
          ),
          SizedBox(width: 30.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontFamily: kQuicksand,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontFamily: kQuicksand,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}