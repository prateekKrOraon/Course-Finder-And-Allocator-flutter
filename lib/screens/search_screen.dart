import 'package:course_finder/screens/college_info_screen.dart';
import 'package:course_finder/screens/course_info_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchScreen extends StatefulWidget{

  SearchScreen({@required this.userId,this.instituteSearch=false});
  final int userId;
  final bool instituteSearch;
  @override
  SearchScreenState createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen>{

  Future _responseBody;
  String _text = "Search";
  NetworkHandler networkHandler;
  int _userId;
  bool instituteSearch;

  @override
  void initState() {
    super.initState();
    instituteSearch = widget.instituteSearch;
    this._userId = widget.userId;
    networkHandler = NetworkHandler();
  }

  Future _getSearchDetail(String search)async{
    //returns search query result as Future object
    return widget.instituteSearch?await networkHandler.getInstituteSearchResult(search): await networkHandler.getSearchResult(search);
  }

  Future _getOptions()async{
    //returns list of all courses as Future object
    return widget.instituteSearch?await networkHandler.getAllInstitutes():await networkHandler.getAllCourses();
  }

  //Bottom sheet builder
  Widget bottomSheetBuilder(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        width: double.infinity,
        height: 300.0,
        child: FutureBuilder(
          future: _getOptions(),
          builder: (context,snapshot){

            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            var list = snapshot.data;
            List<BottomSheetButton> resultList = [];

            if(widget.instituteSearch){
              for(var item in list){
                resultList.add(
                    BottomSheetButton(
                      text: item[kCollegeName],
                      onPressed: (){
                        _responseBody = _getSearchDetail(item[kCollegeId]);
                        setState(() {
                          _text = item[kCollegeName];
                          Navigator.pop(context);
                        });
                      },
                    )
                );
              }
            }
            if(!widget.instituteSearch){
              for(Map item in list){
                resultList.add(
                    BottomSheetButton(
                      text: item[kCourseName],
                      onPressed: (){
                        _responseBody = _getSearchDetail(item[kCourseId]);
                        setState(() {
                          _text = item[kCourseName];
                          Navigator.pop(context);
                        });
                      },
                    )
                );
              }
            }

            //Bottom sheet button builder
            return ListView.builder(
                shrinkWrap: true,
                itemCount: resultList.length,
                itemBuilder: (BuildContext context,index){
                  return resultList[index];
                });
          },
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //search bar container
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              color: Theme.of(context).primaryColor
            ),

            //Search bar
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (String value)async{
                      _text = value;
                      //TODO: implement search
                      _responseBody = _getSearchDetail(_text);
                    },
                    cursorColor: Theme.of(context).accentColor,
                    decoration: InputDecoration(
                      hintText: _text,
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 16.0,
                      ),
                      prefixIcon: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(AntDesign.search1),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 5.0
                      )
                    ),
                  ),
                ),
              ),
            ),//Search TextField
          ),

          //Search screen builder
          FutureBuilder(
            future: _responseBody,
            builder: (context,snapshot){

              List list = snapshot.data;
              if(snapshot.hasError){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
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
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Padding(
                  padding: EdgeInsets.only(top:30.0),
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
              if(!snapshot.hasData){
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Course Finder",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 100.0,
                          fontFamily: kStaleMate,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Find the best courses for you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: kStaleMate,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if(list.isEmpty){
                return Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).accentColor,
                        size: 150.0,
                      ),
                      Text(
                        "No Data available",
                        style: TextStyle(
                          fontFamily: kQuicksand,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                );
              }
              List<ResultTile> resultList = [];

                for(Map item in list){
                  resultList.add(ResultTile(
                    collegeId: item[kCollgeID],
                    iconLink: item[kCollegeIconLink],
                    collegeName: item[kCollegeName],
                    courseName: !widget.instituteSearch?item[kCourseName]:null,
                    location: item[kCollegeLocation],
                    showCourse: !widget.instituteSearch,
                  ));
                }

              return ListView.builder(
                controller: ScrollController(
                  keepScrollOffset: false,
                ),
                shrinkWrap: true,
                itemCount: resultList.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    child: resultList[index],
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => widget.instituteSearch?CollegeInfoScreen(
                          userId: _userId,
                          collegeId: resultList[index].collegeId,
                        ):CourseInfoScreen(
                          userId:_userId,
                          collegeId: resultList[index].collegeId,
                          courseName: resultList[index].courseName,
                        )),
                      );
                    },
                  );
                },
              );
            },
          ),//Search Screen Builder
        ],
      ),
    );
  }
}