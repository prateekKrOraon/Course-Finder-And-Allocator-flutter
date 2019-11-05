import 'package:course_finder/screens/about_app.dart';
import 'package:course_finder/screens/allocated_course_screen.dart';
import 'package:course_finder/screens/dashboard.dart';
import 'package:course_finder/screens/login_screen.dart';
import 'package:course_finder/screens/profile_screen.dart';
import 'package:course_finder/screens/search_screen.dart';
import 'package:course_finder/utilities/backdrop.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Home extends StatefulWidget{

  Home({this.userId,this.screenNumber=0,this.searchData=''});

  final int userId;
  final int screenNumber;
  final String searchData;

  @override
  _HomeState createState() {
    return _HomeState();
  }

}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  int _currentTabIndex;
  int _userId;
  bool _instituteSearch = false;
  bool menuShown = false;
  double menuHeight = 0.0;
  Animation openAnimation;
  AnimationController openController;
  bool toggleText = true;
  String text = "Search Course";
  String searchData;

  @override
  void initState(){
    super.initState();
    _userId = widget.userId;
    searchData = widget.searchData;
    _currentTabIndex = widget.screenNumber;
    openController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );
    openAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(openController);
    openController.reset();
    openController.forward();
  }

  _menuHandler(){
    openController.reset();
    openController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final _kNavPages = <Widget> [
      Dashboard(userId: _userId,),
      SearchScreen(userId: _userId,instituteSearch: _instituteSearch,search: searchData,),
      AllocatedCourses(userId: _userId,),
      ProfileScreen(),
    ];
    searchData = '';
    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(AntDesign.home),title: Text("Home")),
      BottomNavigationBarItem(icon: Icon(AntDesign.search1),title: Text("Search")),
      BottomNavigationBarItem(icon: Icon(SimpleLineIcons.event),title: Text("Allocated courses")),
      BottomNavigationBarItem(icon: Icon(SimpleLineIcons.user),title: Text("Profile"))
    ];

    assert(_kNavPages.length == _kBottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return BackdropScaffold(
      controller: openController,
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
      iconPosition: BackdropIconPosition.action,
      headerHeight: 400,
      backLayer: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BackdropButton(
            icon: AntDesign.edit,
            text: toggleText?"Search Institute":"Search Course",
            onTap: (){
              setState(() {
                _instituteSearch = !_instituteSearch;
                _currentTabIndex = 1;
                toggleText = !toggleText;
              });
              _menuHandler();
            },
          ),
          BackdropButton(
            icon: AntDesign.infocirlceo,
            text: 'About Course Finder',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutApp()));
            },
          ),
          BackdropButton(
            icon: AntDesign.logout,
            text: 'Log out',
            onTap: ()async{
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool(kLoggedIn, false);
              await prefs.setInt(kUserID, 0);
              await prefs.setString(kEmailId,'');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context)=>LoginScreen()),
                    (route)=>false,
              );
            },
          ),
          BackdropButton(
            icon: SimpleLineIcons.logout,
            text: 'Exit',
            onTap: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
      frontLayer: Scaffold(
        body: _kNavPages[_currentTabIndex],
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}