import 'package:course_finder/screens/change_password_screen.dart';
import 'package:course_finder/screens/edit_details_screen.dart';
import 'package:course_finder/services/network_handler.dart';
import 'package:course_finder/utilities/constants.dart';
import 'package:course_finder/utilities/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileScreen extends StatefulWidget{
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}


class ProfileScreenState extends State<ProfileScreen>{

  Future userDetails;
  NetworkHandler networkHandler;

  @override
  void initState() {
    super.initState();
    networkHandler = NetworkHandler();
    this.userDetails = getUserDetails();
  }

  Future getUserDetails() async {
    return await networkHandler.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
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
                'Profile',
                style: TextStyle(
                  fontFamily: kQuicksand,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: userDetails,
            builder: (context,snapshot){
              Map res = snapshot.data;
              if(snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if(snapshot.hasError){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MaterialCommunityIcons.wifi_strength_off_outline,
                          color: Theme.of(context).accentColor,
                          size: 150.0,
                        ),
                        Text(
                          "Connection Error\nCheck your internet connection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: kQuicksand,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.grey[600],
                        size: 100.0,
                      ),
                      radius: 50.0,
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                    Text(
                      res[kFullName],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: kQuicksand,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 50.0
                      ),
                      child: Container(
                        color: Colors.grey[600],
                        width: double.infinity,
                        height: 1.0,
                      ),
                    ),
                    Card(
                      elevation: 2.0,
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Personla info',
                              style: TextStyle(
                                fontFamily: kQuicksand,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Divider(height: 20.0,color: Theme.of(context).accentColor,),

                            CustomListTile(
                              header: 'Email',
                              text: res[kEmailId],
                              icon: AntDesign.mail,
                            ),
                            CustomListTile(
                              header: 'Phone Number',
                              text: res[kPhoneNo],
                              icon: AntDesign.phone,
                            ),
                            CustomListTile(
                              header: 'Qualification',
                              text: res[kQualification],
                              icon: AntDesign.edit,
                            ),
                            CustomListTile(
                              header: 'City',
                              text: res[kCity],
                              icon: SimpleLineIcons.location_pin,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomFlatButton(
                      text: "Edit Details",
                      icon: SimpleLineIcons.pencil,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder:(context) => EditDetailsScreen(
                            email: res[kEmailId],
                            name: res[kFullName],
                            phoneNo: res[kPhoneNo],
                            qual: res[kQualification],
                            city: res[kCity],
                          ),
                        ),);
                      },
                    ),
                    Hero(
                      tag: 'change_password',
                      child: CustomFlatButton(
                        text: "Change Password",
                        icon: SimpleLineIcons.pencil,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(emailId:res[kEmailId])));
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}