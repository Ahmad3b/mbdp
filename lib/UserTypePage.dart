import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/Controls/CustomTextEntryField.dart';
import 'package:mbdp/LoginPage.dart';
import 'package:mbdp/NurserySchool/RegisterSchool.dart';
import 'package:mbdp/Parents/ParentsHome.dart';
import 'package:mbdp/UserTypes.dart';
import 'package:provider/provider.dart';

import 'Controls/CustomButton.dart';

import 'Services/AuthenticationService.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class UserTypePage extends StatefulWidget {
  @override
  _UserTypePageState createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(198, 223, 223, 1),
              ),
              child: Column(children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'))),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    onUserTypeSelected(UserTypes.SchoolAdmin);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 80,
                      child: Text(
                        "Nursery Admin",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    onUserTypeSelected(UserTypes.SchoolTeacher);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 80,
                      child: Text(
                        "Nursery Teacher",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    onUserTypeSelected(UserTypes.SchoolDriver);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 80,
                      child: Text(
                        "Nursery Driver",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    onUserTypeSelected(UserTypes.Parent);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 80,
                      child: Text(
                        "Parent",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  height: 20,
                )
              ]))),
    );
  }

  void onUserTypeSelected(UserTypes userType) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage(userType: userType)));
  }
}
