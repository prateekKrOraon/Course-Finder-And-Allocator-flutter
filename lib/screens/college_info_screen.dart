import 'package:course_finder/screens/course_info_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CollegeInfoScreen extends StatefulWidget{

  CollegeInfoScreen({this.collegeId,this.userId});

  final int collegeId;
  final int userId;
  @override
  _CollegeInfoScreenState createState() {
    return _CollegeInfoScreenState();
  }
}

class _CollegeInfoScreenState extends State<CollegeInfoScreen>{

  int _collegeId;
  NetworkHandler networkHandler;
  Future instituteDetail;
  Future instituteCourses;
  int _userId;

  @override
  void initState() {
    super.initState();
    _collegeId = widget.collegeId;//widget.collegeId;
    _userId = widget.userId;
    networkHandler = NetworkHandler();
    instituteDetail = getInstituteDetails(_collegeId.toString());
    instituteCourses = getInstituteCourses(_collegeId.toString());
  }

  Future getInstituteDetails(String collegeId)async{
    return await networkHandler.getInstituteDetail(collegeId);
  }

  Future getInstituteCourses(String collegeId)async{
    return await networkHandler.getInstituteCourses(collegeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.school),
            SizedBox(width:8.0),
            Text(
              'Course Finder',
              style: TextStyle(
                fontFamily: kQuicksand,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: instituteDetail,
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(!snapshot.hasData){
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            size: 150.0,
                          ),
                          SizedBox(height: 30.0,),
                          Text(
                            'No Data Available',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50.0,
                              fontFamily: kQuicksand,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  List list = snapshot.data;
                  Map result = list[0];
                  return Column(
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
                                        Icons.location_on,
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
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0
                                  ),
                                  child: Text(
                                    "Quick Facts",
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).accentColor,
                                  height: 10.0,
                                ),
                                QuickFacts(
                                  owner: result[kOwner],
                                  type: result[kType],
                                  totalFaculty: result[kTotalFaculty],
                                  year: result[kEstdYear],
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 2.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0
                                  ),
                                  child: Text(
                                    "About Institute",
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).accentColor,
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    result[kCollegeDes],
                                    style: TextStyle(
                                      fontFamily: kNotoSansSC,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              FutureBuilder(
                future: instituteCourses,
                builder: (BuildContext context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(!snapshot.hasData){
                    return Column(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          size: 100.0,
                        ),
                        Text(
                          'Programme data not availabe',
                          style: TextStyle(
                            fontFamily: kQuicksand,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    );
                  }


                  List result = snapshot.data;

                  if(result.isEmpty){
                    return Column(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          size: 100.0,
                        ),
                        Text(
                          'Programme data not availabe',
                          style: TextStyle(
                            fontFamily: kQuicksand,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    );
                  }
                  List<CourseButton> resultList = [];
                  for(Map item in result){
                    resultList.add(
                      CourseButton(
                        courseDuration: item[kCourseDuration],
                        cost: item[kCourseCost],
                        collegeId: item[kCollegeId],
                        courseName: item[kCourseName],
                        courseId: item[kCourseId],
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CourseInfoScreen(
                              collegeId: item[kCollegeId],
                              courseName: item[kCourseName],
                              userId: _userId,
                            ),
                            ),);
                        },
                      )
                    );
                  }

                  return Card(
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30.0,
                          ),
                          child: Text(
                            "Programmes",
                            style: TextStyle(
                              fontFamily: kQuicksand,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                          height: 20.0,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          controller: ScrollController(
                            keepScrollOffset: false
                          ),
                          shrinkWrap: true,
                          itemCount: resultList.length,
                          itemBuilder: (BuildContext context,index){
                            return Column(
                              children: <Widget>[
                                resultList[index],
                                Divider(
                                  height: 1.0,
                                  color: Theme.of(context).accentColor,
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              FutureBuilder(
                future: instituteDetail,
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return SizedBox();
                  }
                  return Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 30.0,
                            ),
                            child: Text(
                              "Facilities",
                              style: TextStyle(
                                fontFamily: kQuicksand,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).accentColor,
                            height: 20.0,
                          ),
                          GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    SimpleLineIcons.symbol_male,
                                    size: 35.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    'Boys Hostel',
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    SimpleLineIcons.symbol_female,
                                    size: 35.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    'Girls Hostel',
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    SimpleLineIcons.book_open,
                                    size: 35.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    'Library',
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.basketball,
                                    size: 35.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(
                                    'Sports',
                                    style: TextStyle(
                                      fontFamily: kQuicksand,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}