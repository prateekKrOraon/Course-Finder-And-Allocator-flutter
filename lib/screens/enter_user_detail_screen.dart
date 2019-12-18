import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login_screen.dart';

class InputUserDetail extends StatefulWidget{

  InputUserDetail({this.email});
  final String email;

  @override
  _InputUserDetailState createState() => _InputUserDetailState();
}

class _InputUserDetailState extends State<InputUserDetail>{

  String _fullName;
  String _phone;
  String _city;
  String _selectedQual;
  String _selectedDate = "Click to select";
  Map _responseBody;
  bool _showSpinner = false;
  String _emailId;

  NetworkHandler networkHandler = NetworkHandler();


  _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980,8),
        lastDate: DateTime(2025)
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _selectedDate = new DateFormat("dd-MM-yyyy").format(selectedDate).toString();
      });
    }
  }

  List _qualificationsList = [
    'Intermediate (Mthematics)',
    'Intermediate (Biology)',
    'Intermediate (Commerce)',
    'B.Sc.',
    'B.Tech',
    'M.Tech',
    'M.Sc.',
    'BBA',
    'MBA',
    'BCA',
    'MCA',
    'BA',
  ];

  List<DropdownMenuItem> getDropDownList(){
    List<DropdownMenuItem> list = [];
    for(String item in _qualificationsList){
      list.add(DropdownMenuItem(child: Text(item),value: item,));
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _emailId = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'title',
                child: Text(
                  "Enter Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 100.0,
                    fontFamily: 'Stalemate',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  InputTextField(
                    labelText: "Full Name",
                    icon: Icons.person_outline,
                    onChanged: (String value){
                      _fullName = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputTextField(
                    labelText: "Phone Number",
                    icon: AntDesign.phone,
                    onChanged: (String value){
                      _phone = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputTextField(
                    labelText: "City",
                    icon: SimpleLineIcons.location_pin,
                    onChanged: (String value){
                      _city = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      title: Text("Qualification",style: TextStyle(fontSize: 18.0,color: Colors.grey[600]),),
                      trailing: DropdownButton(
                        hint: Text("Select one"),
                        value: _selectedQual,
                        items: getDropDownList(),
                        onChanged: (value){
                          setState(() {
                            _selectedQual = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      title: Text("Date of Birth",style: TextStyle(fontSize: 18.0,color: Colors.grey[600]),),
                      trailing: FlatButton(
                        child: Text(_selectedDate,style: TextStyle(fontSize: 14.0,color: Colors.grey[600]),),
                        onPressed: (){
                          _selectDate(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Hero(
                tag: 'button',
                child: CustomRaisedButton(
                  text: "Confirm",
                  onPressed: ()async{
                    setState(() {
                      _showSpinner = true;
                    });
                    _responseBody = await networkHandler.sendUserDetails(_emailId,_fullName, _phone, _city, _selectedQual, _selectedDate);
                    if(!_responseBody[kError]){
                      setState(() {
                        _showSpinner = false;
                      });
                      //await saveToSharedPref(true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),(route)=>false);
                    }else{
                      setState(() {
                        _showSpinner = false;
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}