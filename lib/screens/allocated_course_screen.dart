import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AllocatedCourses extends StatefulWidget{

  AllocatedCourses({this.userId});

  final int userId;

  @override
  _AllocatedCoursesState createState() {
    return _AllocatedCoursesState();
  }

}

class _AllocatedCoursesState extends State<AllocatedCourses>{

  Future allocatedCourses;
  int _userId;

  NetworkHandler networkHandler;
  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    networkHandler = NetworkHandler();
    this.allocatedCourses = getAllocatedCourses();
  }

  Future getAllocatedCourses() async {
    return await networkHandler.getAllocatedCourse(_userId.toString());
  }

  Dialog showAlertDialog(){
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150.0,
        padding: EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(75.0),
            bottomLeft: Radius.circular(75.0),
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                MaterialCommunityIcons.alert_circle_outline,
                size: 100.0,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Confirmation',
                      style: TextStyle(
                        fontFamily: kQuicksand,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                      ),
                    ),
                    SizedBox(height:10.0),
                    Text(
                      'Do you want to De-allocate?',
                      style: TextStyle(
                        fontFamily: kQuicksand,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height:10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: RaisedButton(
                              shape: StadiumBorder(),
                              color: Colors.red,
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontFamily: kQuicksand,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: (){
                                Navigator.pop(context,'No');
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: RaisedButton(
                              shape: StadiumBorder(),
                              color: Colors.green,
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontFamily: kQuicksand,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: (){
                                Navigator.pop(context,'Yes');
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35.0),
                bottomLeft: Radius.circular(35.0),
              ),
            ),
            child: Center(
              child: Text(
                'Allocated Courses',
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: allocatedCourses,
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MaterialCommunityIcons.wifi_strength_off_outline,
                          color: Theme.of(context).accentColor,
                          size: 150.0,
                        ),
                        Text(
                          "Connection Error\nCheck your internet connection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: kQuicksand,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: CircularProgressIndicator(),
                );
              }
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List list = snapshot.data;
              List<ResultTile> resultList = [];

              if(list.isEmpty){
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Icon(
                        MaterialCommunityIcons.message_alert_outline,
                        size: 150.0,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'You have not been alloted any course',
                        style: TextStyle(
                          fontFamily: kQuicksand,
                          fontSize: 30.0,
                        ),
                      )
                    ],
                  ),
                );
              }
              for(Map item in list){
                resultList.add(ResultTile(
                  collegeName: item[kCollegeName],
                  collegeId: item[kCollegeId],
                  courseName: item[kCourseName],
                  location: item[kCollegeLocation],
                  iconLink: item[kCollegeIconLink],
                  courseId: item[kCourseId],
                  showCourse: true,
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: resultList.length,
                itemBuilder: (BuildContext context, index){
                  return GestureDetector(
                    onLongPress: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showAlertDialog();
                        }
                      ).then((returnVal)async{
                        if(returnVal == 'Yes'){
                          Map result = await networkHandler.deAllocate(
                            _userId.toString(),
                            resultList[index].courseId.toString(),
                            resultList[index].collegeId.toString(),
                          );
                          setState(() {
                            allocatedCourses = getAllocatedCourses();
                          });
                          if(!result[kError]){
                            Scaffold.of(context).showSnackBar(showSnackBar(
                                text: result[kMessage],
                                icon: AntDesign.check,
                                color: Colors.green,
                                onPressed: (){

                                }
                            ));
                          }else{
                            Scaffold.of(context).showSnackBar(showSnackBar(
                                text: result[kMessage],
                                icon: Icons.error_outline,
                                color: Colors.red,
                                onPressed: (){
                                  //TODO
                                }
                            ));
                          }
                        }
                      });
                    },
                    child: resultList[index],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

}