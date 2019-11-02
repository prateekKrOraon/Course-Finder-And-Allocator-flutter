import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

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

  AlertDialog showAlertDialog(){
    return AlertDialog(
      title: Text(
        'Confirmation',
        style: TextStyle(
            fontFamily: kQuicksand,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      ),
      content: Text(
          'Do you want to De-allocate?'
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: (){
            Navigator.pop(context,'No');
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: (){
            Navigator.pop(context,'Yes');
          },
        ),
      ],
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
      body: FutureBuilder(
        future: allocatedCourses,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData){
            return Center(
              child: Column(
                children: <Widget>[
                  Icon(Icons.announcement,size: 100.0,color: Theme.of(context).accentColor,),
                  Text(
                    'You have not been alloted any course'
                  )
                ],
              ),
            );
          }
          List list = snapshot.data;
          List<ResultTile> resultList = [];
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
                            icon: Icons.check,
                            color: Colors.green,
                            onPressed: (){

                            }
                        ));
                      }else{
                        Scaffold.of(context).showSnackBar(showSnackBar(
                            text: result[kMessage],
                            icon: Icons.error,
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
    );
  }

}