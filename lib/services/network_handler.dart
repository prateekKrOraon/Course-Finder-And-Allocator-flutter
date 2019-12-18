import 'package:course_finder/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHandler{

  String _globalURL = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services';
  Map<String,String> _header = {"Accept":"application/json"};


  Future<Map> loginUser(String email,String password) async {
    Map send = {
      kEmailId:email,
      kPassword:password,
    };
    String url = '$_globalURL/loginRequest.php';
    var res = await http.post(url,headers: _header,body: send);
    return jsonDecode(res.body);

  }
  //Login part ends here

  //Sign up
  Future<Map> signUpUser(String email, String password) async {

    Map send = {
      kEmailId:email,
      kPassword:password,
    };

    String _url = '$_globalURL/registerUser.php';
    var res = await http.post(_url,body: send);
    return jsonDecode(res.body);

  }

  //Sign up part ends here

  //Sending user details

  Future<Map> sendUserDetails(String emailId, String fullName,String phone,String city, String qualification, String dob) async {
    Map send = {
      kEmailId:emailId,
      kFullName:fullName,
      kDOB:dob,
      kCity:city,
      kPhoneNo:phone,
      kQualification:qualification,
    };

    String url = '$_globalURL/enterUserDetails.php';

    var res = await http.post(url,headers: _header,body: send);
    return jsonDecode(res.body);
  }
  //Sending User Details ends here

  //Get user details

  Future getUserDetails(String userId) async {

    String url = '$_globalURL/getUserDetails.php';
    var res = await http.post(url,headers: _header,body: {kUserID:userId});
    return jsonDecode(res.body);

  }

  //getting user details ends here

  //get Search result
  Future getSearchResult(String search)async{
    String url = '$_globalURL/getSearchResult.php';
    var res = await http.post(url,headers: _header,body: {kSearch:search});
    var a = jsonDecode(res.body);
    return jsonDecode(a);
  }

  Future getInstituteSearchResult(String search)async{
    String url = '$_globalURL/getInstituteSearchResult.php';
    var res = await http.post(
      url,
      headers: _header,
      body: {kSearch:search}
    );
    var a = jsonDecode(res.body);
    return jsonDecode(a);
  }

  //getting search detail ends here

  Future getCourseDetail(String courseName,int collegeId)async{
    String url = '$_globalURL/getCourseDetail.php';
    var res = await http.post(url,headers: _header,body: {kCourseName:courseName,kCollegeId:collegeId.toString()});
    return jsonDecode(res.body);
  }

  //search details ends here

  //getting all courses

  Future getAllCourses()async{
    String url = '$_globalURL/getAllCourses.php';
    var res = await http.post(url,headers: _header);
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  //getting all courses

  //get allocated courses

  Future getAllocatedCourse(String userId) async {
    String url = '$_globalURL/getAllocatedCourses.php';
    var res = await http.post(url,headers: _header,body: {kUserID:userId});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  //get allocated courses

  //change password

  Future changePassword(String emailId,String prev, String newPass)async{
    String url = '$_globalURL/changePassword.php';
    var res = await http.post(url,headers: _header,body: {kEmailId:emailId,kPrevPass:prev,kNewPass:newPass});
    var json = jsonDecode(res.body);
    return json;
  }

  //change password ends

  //updateUserDetails

  Future updateUserDetails({String emailId,String name,String phoneNo,String qual,String city})async{
    String url = '$_globalURL/updateUserDetails.php';
    var res = await http.post(
      url,
      headers: _header,
      body: {
        kEmailId:emailId,
        kFullName:name,
        kPhoneNo:phoneNo,
        kQualification:qual,
        kCity:city,
      },
    );
    var json = jsonDecode(res.body);
    return json;
  }

  //updateUserDetails ends

  Future allocateCourse(int userId, int courseId, int collegeId)async{
    String url = '$_globalURL/allocateCourse.php';
    var res = await http.post(
      url,
      headers: _header,
      body: {
        kUserID:userId.toString(),
        kCourseId:courseId.toString(),
        kCollegeId:collegeId.toString(),
      },
    );
    var json = jsonDecode(res.body);
    return json;
  }

  //Update user details ends

  //De-allocate course

  Future deAllocate(String userId,String courseId,String collegeId)async{
    String url = '$_globalURL/deAllocate.php';
    var res = await http.post(
      url,
      headers: _header,
      body: {kUserID:userId,kCourseId:courseId,kCollegeId:collegeId},
    );
    return jsonDecode(res.body);
  }

  //de-allocate ends

  Future getAllInstitutes()async{
    String url = '$_globalURL/getAllInstitutes.php';
    var res = await http.post(
      url,
      headers: _header,
    );
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  Future getInstituteDetail(String collegeId)async{
    String url = '$_globalURL/getInstituteDetails.php';
    var res = await http.post(url,headers: _header,body: {kCollegeId:collegeId});
    var json = jsonDecode('[${res.body}]');
    return json;
  }

  Future getInstituteCourses(String collegeId)async{
    String url = '$_globalURL/getInstituteCourses.php';
    var res = await http.post(url,headers: _header,body: {kCollegeId:collegeId});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  Future getPageViewItems(String qual)async{
    String url = '$_globalURL/getPageViewItems.php';
    var res = await http.post(url,headers: _header,body: {kQualification:qual});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }
}