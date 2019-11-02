import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard>{

  PageController _pageController;

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

  List<CustomDashboardChips> courseButtons = [
    CustomDashboardChips(
      text: 'B.Tech.',
    ),
    CustomDashboardChips(
      text: 'M.Tech.',

    ),
    CustomDashboardChips(
      text: 'M.Sc.',
    ),
    CustomDashboardChips(
      text: 'B.Sc.',
    ),
    CustomDashboardChips(
      text: 'MBBS',
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
    ),
    CustomDashboardChips(
      text: 'JEE Advance',

    ),
    CustomDashboardChips(
      text: 'NEET',
    ),
    CustomDashboardChips(
      text: 'GATE',
    ),
  ];

  void initState() {
    super.initState();
    networkHandler = NetworkHandler();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    _pageViewItems = _getPageViewItems('Intermediate');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          FutureBuilder(
            future: _pageViewItems,
            builder: (context,snapshot){
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
                resultList.add(ResultTile(
                  courseName: item[kCourseName],
                  courseId: item[kCourseId],
                  showCourse: true,
                  collegeId: item[kCollegeId],
                  collegeName: item[kCollegeName],
                  iconLink: item[kCollegeIconLink],
                  location: item[kCollegeName],
                ));
                imageLinks.add(item[kCollegeImageLink]);
              }

              return Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemCount: resultList.length,
                      itemBuilder: (BuildContext context, index){
                        return _itemSelector(index,resultList,imageLinks);
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
    );
  }

}