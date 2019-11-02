import 'package:course_finder/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(CourseFinder());

class CourseFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Finder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[600]
      ),
      home: LoginScreen(),
    );
  }
}

