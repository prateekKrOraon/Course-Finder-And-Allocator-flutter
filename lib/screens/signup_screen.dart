import 'package:course_finder/screens/enter_user_detail_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SignUpScreen extends StatefulWidget{
  @override
  _SignUpScreenState createState() {
    return _SignUpScreenState();
  }

}

class _SignUpScreenState extends State<SignUpScreen>{

  String _email;
  String _password;
  String _cnf;
  Map _responseBody;
  bool showSpinner = false;

  NetworkHandler networkHandler = NetworkHandler();

//  saveToSharedPref(String email)async{
//    final prefs = await SharedPreferences.getInstance();
//    await prefs.setString(kEmailId, kEmailId);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Course Finder",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 100.0,
                  fontFamily: 'Stalemate',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: <Widget>[
                  InputTextField(
                    labelText: "E-mail",
                    icon: AntDesign.mail,
                    onChanged: (String value){
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputTextField(
                    labelText: "Password",
                    icon: SimpleLineIcons.lock,
                    obscureText: true,
                    onChanged: (String value){
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputTextField(
                    labelText: "Confirm Password",
                    icon: AntDesign.phone,
                    obscureText: true,
                    onChanged: (String value){
                      _cnf = value;
                    },
                  ),
                ],
              ),
              Builder(
                builder: (context)=>
                Hero(
                  tag: 'button',
                  child: CustomRaisedButton(
                    text: "Sign Up",
                    onPressed: ()async{
                      if(_password != _cnf){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Password do not match"),
                          action: SnackBarAction(label: 'OK', onPressed: (){},),
                        ));
                      }else{
                        setState(() {
                          showSpinner = true;
                        });
                        _responseBody = await networkHandler.signUpUser(_email, _password);
                        if(!_responseBody[kError]){
                          //await saveToSharedPref(_email);
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>InputUserDetail(email:_email,)),(route)=>false);
                        }else{
                          setState(() {
                            showSpinner = false;
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.error),
                                SizedBox(width:10.0),
                                Text(_responseBody[kMessage]),
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