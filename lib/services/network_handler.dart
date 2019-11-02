import 'package:course_finder/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHandler{

  Map _responseBody;
  String _globalURL = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services';
  Map<String,String> header = {"Accept":"application/json"};


  //For logging in user
  Future<Map> loginUser(String email,String password) async{
    this._responseBody = await _login(email, password);
    return _responseBody;
  }

  Future<Map> _login(String email,String password) async {
    Map send = {
      'email_id':email,
      'password':password,
    };
    String url = '$_globalURL/loginRequest.php';
    var res = await http.post(url,headers: header,body: send);
    return jsonDecode(res.body);

  }
  //Login part ends here

  //Sign up

  Future<Map> signUpUser(String email,String password)async{
    this._responseBody = await _signUp(email, password);
    return _responseBody;
  }
  Future<Map> _signUp(String email, String password) async {

    Map send = {
      'email_id':email,
      'password':password,
    };

    String _url = '$_globalURL/registerUser.php';
    var res = await http.post(_url,body: send);
    return jsonDecode(res.body);

  }

  //Sign up part ends here

  //Sending user details

  Future<Map> sendUserDetails(String fullName,String phone,String city, String qualification, String dob) async {
    this._responseBody = await _sendDetails(fullName, phone, city, qualification, dob);
    return _responseBody;
  }

  Future<Map> _sendDetails(String fullName,String phone,String city, String qualification, String dob) async {
    Map send = {
      'email_id':'prateekkr.o@gmail.com',
      'full_name':fullName,
      'date_of_birth':dob,
      'city':city,
      'phone_no':phone,
      'qualification':qualification,
    };

    String url = '$_globalURL/enterUserDetails.php';

    var res = await http.post(url,headers: {"Accept":"application/json"},body: send);
    return jsonDecode(res.body);
  }
  //Sending User Details ends here

  //Get user details

  Future getUserDetails() async {

    var responseBody = await _getDetails();
    return responseBody;

  }

  Future _getDetails() async {

    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getUserDetails.php';
    //TODO
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {'email_id':'prateekkr.o@gmail.com'});
    return jsonDecode(res.body);

  }

  //getting user details ends here

  //get Search result

  Future getSearchResult(String search)async{
    var responseBody = await _getResult(search);
    return responseBody;
  }

  Future _getResult(String search)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getSearchResult.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kSearch:search});
    var a = jsonDecode(res.body);
    return jsonDecode(a);
  }

  Future getInstituteSearchResult(String search)async{
    String url = '$_globalURL/getInstituteSearchResult.php';
    var res = await http.post(
      url,
      headers: header,
      body: {kSearch:search}
    );
    var a = jsonDecode(res.body);
    return jsonDecode(a);
  }

  //getting search detail ends here

  Future getCourseDetail(String courseName,int collegeId)async{
    var responseBody = await _getCourseDetail(courseName, collegeId);
    return responseBody;
  }
  Future _getCourseDetail(String courseName,int collegeId)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getCourseDetail.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kCourseName:courseName,kCollegeId:collegeId.toString()});
    return jsonDecode(res.body);
  }

  //search details ends here

  //getting all courses

  Future getAllCourses()async{
    var responseBody = await _getCourses();
    return responseBody;
  }

  Future _getCourses()async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getAllCourses.php';
    var res = await http.post(url,headers: {"Accept":"application/json"});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  //getting all courses

  //get allocated courses

  Future getAllocatedCourse(String userId) async{
    var responseBody = await _getCourse(userId);
    return responseBody;
  }

  Future _getCourse(String userId) async {
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getAllocatedCourses.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kUserID:userId});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  //get allocated courses

  //change password

  Future changePassword(String emailId,String prev, String newPass)async{
    var responseBody = await _changePass(emailId, prev, newPass);
    return responseBody;
  }

  Future _changePass(String emailId,String prev, String newPass)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/changePassword.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kEmailId:emailId,kPrevPass:prev,kNewPass:newPass});
    var json = jsonDecode(res.body);
    return json;
  }

  //change password ends

  //updateUserDetails

  Future updateUserDetails({String emailId,String name,String phoneNo,String qual,String city})async{
    var responseBody = await _updateDetails(emailId, name, phoneNo, qual, city);
    return responseBody;
  }

  Future _updateDetails(String emailId,String name,String phoneNo,String qual,String city)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/updateUserDetails.php';
    var res = await http.post(
      url,
      headers: {"Accept":"application/json"},
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
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/allocateCourse.php';
    var res = await http.post(
      url,
      headers: {"Accept":"application/json"},
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
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/deAllocate.php';
    var res = await http.post(
      url,
      headers: {"Accept":"application/json"},
      body: {kUserID:userId,kCourseId:courseId,kCollegeId:collegeId},
    );
    return jsonDecode(res.body);
  }

  //de-allocate ends

  Future getAllInstitutes()async{
    var responseBody = await getInstitutes();
    return responseBody;
  }

  Future getInstitutes()async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getAllInstitutes.php';
    var res = await http.post(
      url,
      headers: {"Accept":"application/json"},
    );
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  Future getInstituteDetail(String collegeId)async{
    var responseBody = await _getInstituteDetail(collegeId);
    return responseBody;
  }

  Future _getInstituteDetail(String collegeId)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getInstituteDetails.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kCollegeId:collegeId});
    var json = jsonDecode('[${res.body}]');
    return json;
  }

  Future getInstituteCourses(String collegeId)async{
    String url = 'http://course-finder-prateek.000webhostapp.com/course_finder_app/services/getInstituteCourses.php';
    var res = await http.post(url,headers: {"Accept":"application/json"},body: {kCollegeId:collegeId});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }

  Future getPageViewItems(String qual)async{
    String url = '$_globalURL/getPageViewItems.php';
    var res = await http.post(url,headers: header,body: {kQualification:qual});
    var json = jsonDecode(res.body);
    return jsonDecode(json);
  }
}