import 'package:course_finder/screens/college_info_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CourseInfoScreen extends StatefulWidget{
  CourseInfoScreen({this.userId,this.courseName,this.collegeId});

  final int userId;
  final int collegeId;
  final String courseName;
  @override
  _CourseInfoScreenState createState() {
    return _CourseInfoScreenState();
  }
}

class _CourseInfoScreenState extends State<CourseInfoScreen>{

  int collegeId;
  int userId;
  String courseName;
  Future courseDetail;
  bool waiting = false;

  NetworkHandler networkHandler;
  @override
  void initState() {
    super.initState();
    networkHandler = NetworkHandler();
    this.userId = widget.userId;
    collegeId = widget.collegeId;
    courseName = widget.courseName;
    courseDetail = getInstituteInfo();
  }

  SnackBar showSnackBar({String text,Color color,IconData icon,Function onPressed}){
    return SnackBar(
      backgroundColor: color,
      content: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width:10.0),
          Text(text),
        ],
      ),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: onPressed,
      ),
    );
  }

  Future getInstituteInfo()async{
    return await networkHandler.getCourseDetail(courseName, collegeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details"
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future:courseDetail,
          builder: (context, snapshot){

            Map result = snapshot.data;
            if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).accentColor,
                      size: 100.0,
                    ),
                    Text(
                      "Connection Error\nCheck your internet connection",
                      style: TextStyle(
                        fontFamily: kQuicksand,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              );
            }
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 250.0,
                    width: double.infinity,
                    child: Image.network(
                      result[kCollegeImageLink],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                result[kCollegeName],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: kQuicksand,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    SimpleLineIcons.location_pin,
                                    size: 18.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    result[kCollegeLocation],
                                    style: TextStyle(
                                      fontFamily: kNotoSansSC,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      result[kCourseName],
                                      style: TextStyle(
                                        fontFamily: kQuicksand,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "\u20B9 ${result[kCourseCost]}\n${result[kCourseDuration]}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: kQuicksand,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Seats",
                                      style: TextStyle(
                                        fontFamily: kQuicksand,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      result[kSeats].toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: kQuicksand,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Course Requirement",
                                style: TextStyle(
                                  fontFamily: kQuicksand,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                                height: 20.0,
                              ),
                              //SizedBox(height: 10.0,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextListTile(
                                    title: "Minimum Qualification",
                                    trailing: result[kMinQual],
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextListTile(
                                    title: "Minimum Aggregate",
                                    trailing: result[kMinAgg],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0,right: 50.0,left: 50.0),
                        child: FlatButton(
                          shape: StadiumBorder(
                            side: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.0),

                          child: waiting? CircularProgressIndicator():Text(
                            "Apply Now",
                            style: TextStyle(
                              fontFamily: kQuicksand,
                              fontSize: 30.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: ()async{
                            setState(() {
                              waiting = true;
                            });
                            var response = await networkHandler.allocateCourse(userId, result[kCourseId], collegeId);
                            setState(() {
                              waiting = false;
                            });
                            if(!response[kError]){
                              Scaffold.of(context).showSnackBar(showSnackBar(
                                text: response[kMessage],
                                icon: Icons.check,
                                color: Colors.green,
                                onPressed: (){
                                  Navigator.pop(context);
                                }
                              ));
                            }else{
                              Scaffold.of(context).showSnackBar(showSnackBar(
                                text: response[kMessage],
                                icon: Icons.error,
                                color: Colors.red,
                                onPressed: (){
                                  //TODO
                                }
                              ));
                            }
                          },
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 30.0,
                          left: 4.0,
                          right: 4.0,
                          bottom: 4.0
                        ),
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "About Course",
                                style: TextStyle(
                                  fontFamily: kQuicksand,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                                height: 20.0,
                              ),
                              Text(
                                result[kCourseDetail],
                                style: TextStyle(
                                  fontFamily: kNotoSansSC,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "About Institute",
                                style: TextStyle(
                                  fontFamily: kQuicksand,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                                height: 20.0,
                              ),
                              Text(
                                result[kCollegeDes],
                                style: TextStyle(
                                  fontFamily: kNotoSansSC,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:30.0,horizontal: 50.0),
                        child: FlatButton(
                          shape: StadiumBorder(
                            side: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).accentColor
                            )
                          ),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical:12.0),
                            child: Text(
                              'See full institute details',
                              style: TextStyle(
                                fontFamily: kQuicksand,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CollegeInfoScreen(
                                collegeId: collegeId,
                                userId: userId,
                              ),),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}