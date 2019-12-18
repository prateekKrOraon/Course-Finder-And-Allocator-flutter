import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditDetailsScreen extends StatefulWidget{

  EditDetailsScreen({this.email,this.name,this.phoneNo,this.qual,this.city});

  final String email;
  final String name;
  final String phoneNo;
  final String qual;
  final String city;
  @override
  _EditDetailsScreenState createState() {
    return _EditDetailsScreenState();
  }

}

class _EditDetailsScreenState extends State<EditDetailsScreen>{

  String _name;
  String _phoneNo;
  String _qual;
  String _city;
  String _email;
  NetworkHandler networkHandler;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _qual = widget.qual;
    _phoneNo = widget.phoneNo;
    _city = widget.city;
    _email = widget.email;
    networkHandler = NetworkHandler();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical:30.0),
                  child: Text(
                    "Edit Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: kStaleMate,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InputTextField(
                  labelText: "Name",
                  icon: Icons.person_outline,
                  onChanged: (value){
                    _name = value;
                  },
                ),
                SizedBox(height: 20.0,),
                InputTextField(
                  labelText: "Phone number",
                  icon: AntDesign.phone,
                  onChanged: (value){
                    _phoneNo = value;
                  },
                ),
                SizedBox(height: 20.0,),
                InputTextField(
                  labelText: "Qualification",
                  icon: AntDesign.edit,
                  onChanged: (value){
                    _qual = value;
                  },
                ),
                SizedBox(height: 20.0,),
                InputTextField(
                  labelText: "City",
                  icon: SimpleLineIcons.location_pin,
                  onChanged: (value){
                    _city = value;
                  },
                ),
                SizedBox(height: 50.0,),
                Builder(
                  builder:(context) => CustomFlatButton(
                    text: "Change Details",
                    icon: AntDesign.check,
                    onPressed: ()async{
                      setState(() {
                        showSpinner = true;
                      });
                      var response = await networkHandler.updateUserDetails(
                        emailId: _email,
                        name: _name,
                        phoneNo: _phoneNo,
                        qual: _qual,
                        city: _city,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}