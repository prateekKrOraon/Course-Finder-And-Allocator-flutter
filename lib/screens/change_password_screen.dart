import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ChangePassword extends StatefulWidget{

  ChangePassword({this.emailId});

  final String emailId;
  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }

}

class _ChangePasswordState extends State<ChangePassword>{

  String _emailId;
  String _prePassword;
  String _newPassword;
  String _reNewPassword;
  bool _hidden1 = true;
  bool _hidden2 = true;
  bool _hidden3 = true;
  NetworkHandler networkHandler;
  Map response;
  @override
  void initState() {
    super.initState();
    networkHandler = NetworkHandler();
    _emailId = widget.emailId;
  }

  Future getResponse(String previous,String newPass) async {
    return await networkHandler.changePassword(_emailId,previous, newPass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Finder"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical:30.0),
                child: Text(
                  "Change Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: kStaleMate,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InputTextField(
                labelText: "Previous Password",
                icon: _hidden1? SimpleLineIcons.lock:SimpleLineIcons.lock_open,
                obscureText: _hidden1,
                onChanged: (value){
                  _prePassword = value;
                },
                onTap: (){
                  setState(() {
                    _hidden1 = _hidden1? false:true;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              InputTextField(
                labelText: "New Password",
                icon: _hidden2? SimpleLineIcons.lock:SimpleLineIcons.lock_open,
                obscureText: _hidden2,
                onChanged: (value){
                  _newPassword = value;
                },
                onTap: (){
                  setState(() {
                    _hidden2 = _hidden2? false:true;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              InputTextField(
                labelText: "Confirm New Password",
                icon: _hidden3? SimpleLineIcons.lock:SimpleLineIcons.lock_open,
                obscureText: _hidden3,
                onChanged: (value){
                  _reNewPassword = value;
                },
                onTap: (){
                  setState(() {
                    _hidden3 = _hidden3? false:true;
                  });
                },
              ),
              SizedBox(height: 50.0,),
              Hero(
                tag: 'change_password',
                child: Builder(
                  builder: (context) => CustomFlatButton(
                    text: "Change Password",
                    icon: SimpleLineIcons.pencil,
                    onPressed: ()async{
                      if((_reNewPassword != _newPassword) || _newPassword == null || _reNewPassword == null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: <Widget>[
                              Icon(Icons.error),
                              SizedBox(width:10.0),
                              Text("New Password did not match"),
                            ],
                          ),
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: "OK",
                            textColor: Colors.white,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ));
                      }else if(_newPassword == _prePassword){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: <Widget>[
                              Icon(Icons.error),
                              SizedBox(width:10.0),
                              Text("New Password is same as old password"),
                            ],
                          ),
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: "OK",
                            textColor: Colors.white,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ));
                      }else{
                        response = await getResponse(_prePassword, _newPassword);
                        if(!response[kError]){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.check),
                                SizedBox(width:10.0),
                                Text("Password changed"),
                              ],
                            ),
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: "OK",
                              textColor: Colors.white,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ));
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.error),
                                SizedBox(width:10.0),
                                Text(response[kMessage]),
                              ],
                            ),
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: "OK",
                              textColor: Colors.white,
                              onPressed: (){
                                //TODO
                              },
                            ),
                          ));
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}