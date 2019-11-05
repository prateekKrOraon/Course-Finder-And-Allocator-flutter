import 'package:course_finder/screens/course_info_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{

  Dashboard({this.userId});
  final int userId;

  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard>{

  PageController _pageController;
  int _userId;

  _itemSelector(int index,List<ResultTile> tile,List images){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context,Widget widget){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1-(value.abs()*0.3)+0.7).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            width: Curves.easeInOut.transform(value)*1000.0,
            child: widget,
          ),
        );
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0,vertical: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
          ),
          child: tile[index],
        ),
      ),
    );
  }

  Future _pageViewItems;
  NetworkHandler networkHandler;
  Future _getPageViewItems(String qual)async{
    return await networkHandler.getPageViewItems(qual);
  }



  void initState() {
    super.initState();
    _userId = widget.userId;
    networkHandler = NetworkHandler();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    _pageViewItems = _getPageViewItems('Intermediate');
  }

  @override
  Widget build(BuildContext context) {

    List<CustomDashboardChips> courseButtons = [
      CustomDashboardChips(
        text: 'B.Tech.',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'M.Tech.',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'M.Sc.',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'B.Sc.',
      ),
      CustomDashboardChips(
        text: 'MBBS',
        userId: _userId,
      ),
    ];

    List<CustomDashboardTile> instituteList = [
      CustomDashboardTile(
        text: 'NITs',
      ),
      CustomDashboardTile(
        text: 'IITs',
      ),
      CustomDashboardTile(
        text: 'IIMs',
      ),
      CustomDashboardTile(
        text: 'AIIMS',
      ),
    ];

    List<CustomDashboardChips> examButtons = [
      CustomDashboardChips(
        text: 'JEE Mains.',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'JEE Advance',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'NEET',
        userId: _userId,
      ),
      CustomDashboardChips(
        text: 'GATE',
        userId: _userId,
      ),
    ];

    return SingleChildScrollView(
      //padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
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
                'Home',
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FutureBuilder(
                  future: _pageViewItems,
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      return SizedBox(height: 10.0,);
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }


                    List list = snapshot.data;
                    List<ResultTile> resultList = [];
                    List imageLinks = [];
                    for(Map item in list){
                      resultList.add(
                        ResultTile(
                          courseName: item[kCourseName],
                          courseId: item[kCourseId],
                          showCourse: true,
                          collegeId: item[kCollegeId],
                          collegeName: item[kCollegeName],
                          iconLink: item[kCollegeIconLink],
                          location: item[kCollegeName],
                        ),
                      );
                      imageLinks.add(item[kCollegeImageLink]);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text(
                          'Recommedations',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: kQuicksand,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0
                          ),
                        ),
                        Container(
                          height: 150,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            itemCount: resultList.length,
                            itemBuilder: (BuildContext context, index){
                              return GestureDetector(
                                child: _itemSelector(index,resultList,imageLinks),
                                onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseInfoScreen(
                                      userId: widget.userId,
                                      collegeId: resultList[index].collegeId,
                                      courseName: resultList[index].courseName,
                                    ),
                                  ),
                                );
                              },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2.0,bottom: 10.0),
                          child: Text(
                            'Courses',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).accentColor,height: 1.0,),
                        GridView.builder(
                          controller: ScrollController(
                            keepScrollOffset: false,
                          ),
                          shrinkWrap: true,
                          itemCount: courseButtons.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: courseButtons[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2.0,bottom: 10.0),
                          child: Text(
                            'Institutes',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).accentColor,height: 1.0,),
                        GridView.builder(
                          controller: ScrollController(
                            keepScrollOffset: false,
                          ),
                          shrinkWrap: true,
                          itemCount: instituteList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1),
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: instituteList[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 2.0,bottom: 10.0),
                          child: Text(
                            'Exams',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: kQuicksand,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).accentColor,height: 1.0,),
                        GridView.builder(
                          controller: ScrollController(
                            keepScrollOffset: false,
                          ),
                          shrinkWrap: true,
                          itemCount: examButtons.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: examButtons[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}