import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/Controls/CustomTextEntryField.dart';
import 'package:mbdp/Drivers/BusDriversHome.dart';
import 'package:mbdp/NurserySchool/NurseryDashboard.dart';
import 'package:mbdp/NurserySchool/RegisterSchool.dart';
import 'package:mbdp/Parents/ParentsHome.dart';
import 'package:mbdp/Parents/RegisterParent.dart';
import 'package:mbdp/UserTypes.dart';
import 'package:provider/provider.dart';

import 'Controls/CustomButton.dart';

import 'Services/AuthenticationService.dart';
import 'Services/DataStoreService.dart';
import 'Teacher/TeacherHome.dart';

class LoginPage extends StatefulWidget {
  final UserTypes userType;
  const LoginPage({Key? key, required this.userType}) : super(key: key);

  @override
  _LoginPagetState createState() => _LoginPagetState();
}

class _LoginPagetState extends State<LoginPage> {
  bool rememebrMe = false;
  TextEditingController _loginName = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LogininmanagerWidget - FRAME

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              width: double.infinity,
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
                const Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(34, 73, 87, 1),
                      fontSize: 32,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      decoration: TextDecoration.none),
                ),
                Text(
                  'Welcome ' + getUserName(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromRGBO(34, 73, 87, 1),
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      decoration: TextDecoration.none),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 50, right: 50),
                    child: Column(children: <Widget>[
                      //Username
                      CustomTextEntryField(
                        hintText: 'User Name',
                        inptcontroller: _loginName,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Passsword
                      CustomTextEntryField(
                        hintText: 'Password',
                        isPassword: true,
                        inptcontroller: _password,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: <Widget>[
                        Checkbox(
                          value: rememebrMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememebrMe = value!;
                            });
                          },
                        ),
                        Text('Remeber Me',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              height: 1,
                              letterSpacing: 0,
                            )),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        ButtonLabel: 'Login',
                        onPressed: () async {
                          await login();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (widget.userType != UserTypes.SchoolTeacher ||
                          widget.userType != UserTypes.SchoolDriver)
                        Row(children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              switch (widget.userType) {
                                case UserTypes.Parent:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterParent()));
                                  break;
                                case UserTypes.SchoolAdmin:
                                  Navigator.push(
                                      context,

                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterSchool()));
                                  break;
                                default:
                              }
                            },
                            child: Text('Register New Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1,
                                  letterSpacing: 0,
                                )),
                          ),
                        ]),
                    ])),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: SvgPicture.asset(
                    '',
                    semanticsLabel: 'home',
                  ),
                ),
              ]))),
    );
  }

  String getUserName() {
    switch (widget.userType) {
      case UserTypes.Parent:
        return "Parent";
      case UserTypes.SchoolAdmin:
        return "Nursery Admin";
      case UserTypes.SchoolDriver:
        return "Nursery Driver";
      case UserTypes.SchoolTeacher:
    }
    return "Nursery Teacher";
  }

  Future<void> parentLogin() async {
    String? result = await context
        .read<AuthenticationService>()
        .signIn(email: _loginName.text.trim(), password: _password.text.trim());

    if (result == "Signed In") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ParentsHome()));
    } else //show snabbar
    {
      SnackBar snackBar = SnackBar(
        content: Text(result ?? 'Faield'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> driverLogin() async {
    String? result = await context
        .read<AuthenticationService>()
        .signIn(email: _loginName.text.trim(), password: _password.text.trim());

    if (result == "Signed In") {
      var teacherProfile = await context
          .read<DataStoreService>()
          .getDriverUserProfile(
              context.read<AuthenticationService>().credential!.user!.uid)
          .then((value) {
        print("School ID " + value["SchoolId"]);
        context.read<AuthenticationService>().setSchoolId(value["SchoolId"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BusDriversHome()));
      });
    } else //show snabbar
    {
      SnackBar snackBar = SnackBar(
        content: Text(result ?? 'Faield'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> schoolAdminLogin() async {
    String? result = await context
        .read<AuthenticationService>()
        .signIn(email: _loginName.text.trim(), password: _password.text.trim());

    print("School Admin Login " + result!);
    if (result == "Signed In") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NurseryDashboard()));
    } else //show snabbar
    {
      SnackBar snackBar = SnackBar(
        content: Text(result),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> teacherLogin() async {
    String? result = await context
        .read<AuthenticationService>()
        .signIn(email: _loginName.text.trim(), password: _password.text.trim());

    if (result == "Signed In") {
      var teacherProfile = await context
          .read<DataStoreService>()
          .getTeacherUserProfile(
              context.read<AuthenticationService>().credential!.user!.uid)
          .then((value) {
        context.read<AuthenticationService>().setSchoolId(value["NurseryId"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TeacherHome()));
      });
    } else //show snabbar
    {
      SnackBar snackBar = SnackBar(
        content: Text(result ?? 'Faield'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> login() async {
    EasyLoading.show();
    try {
      switch (widget.userType) {
        case UserTypes.Parent:
          await parentLogin();
          break;
        case UserTypes.SchoolAdmin:
          await schoolAdminLogin();
          break;
        case UserTypes.SchoolDriver:
          await driverLogin();
          break;
        case UserTypes.SchoolTeacher:
          await teacherLogin();
          break;
      }
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.message);
      }
    }
  }
}
