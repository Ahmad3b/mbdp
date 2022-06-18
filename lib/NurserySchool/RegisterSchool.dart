import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/UserTypes.dart';
import 'package:provider/provider.dart';

import '../Controls/CustomButton.dart';
import '../Controls/CustomTextEntryField.dart';
import '../Models/userAccountModel.dart';
import '../Services/DataStoreService.dart';

class RegisterSchool extends StatefulWidget {
  @override
  _RegisterSchoolState createState() => _RegisterSchoolState();
}

class _RegisterSchoolState extends State<RegisterSchool> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _schoolAdminFullName = new TextEditingController();
  TextEditingController _schoolAdminEmail = new TextEditingController();
  TextEditingController _schoolAdminPassword = new TextEditingController();
  TextEditingController _schoolAdminPhone = new TextEditingController();
  TextEditingController _schoolName = new TextEditingController();
  TextEditingController _City = new TextEditingController();
  TextEditingController _Address = new TextEditingController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(198, 223, 223, 1),
          body: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                child: Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Register Nursery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(34, 73, 87, 1),
                        fontSize: 32,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        decoration: TextDecoration.none),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 50, right: 50),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextEntryField(
                            hintText: 'Nursery Admin Full Name',
                            inptcontroller: _schoolAdminFullName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Username
                          CustomTextEntryField(
                            hintText: 'Nursery Admin Email',
                            inptcontroller: _schoolAdminEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Passsword
                          CustomTextEntryField(
                            hintText: 'Password',
                            isPassword: true,
                            inptcontroller: _schoolAdminPassword,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextEntryField(
                            hintText: 'Phone',
                            isPassword: false,
                            inptcontroller: _schoolAdminPhone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextEntryField(
                            hintText: 'Nursery Name',
                            inptcontroller: _schoolName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextEntryField(
                            hintText: 'City',
                            inptcontroller: _City,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextEntryField(
                            hintText: 'Address',
                            inptcontroller: _Address,
                            maxLine: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                margin: 2,
                                ButtonLabel: 'Register',
                                onPressed: () async {
                                  await registerSchool();
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                margin: 2,
                                ButtonLabel: 'Cancel',
                                onPressed: () async {
                                  Navigator.pop(context);
                                  // await login();
                                },
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                      )),
                ])),
          )),
    );
  }

  Future<void> registerSchool() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        await context.read<DataStoreService>().registerUserAccount(
            context: context,
            userSignupData: userAccountModel(
                UserName: _schoolAdminEmail.text.trim(),
                FullName: _schoolAdminFullName.text.trim(),
                Email: _schoolAdminEmail.text.trim(),
                PhoneNumber: _schoolAdminPhone.text.trim(),
                UserType: UserTypes.SchoolAdmin.index),
            OnSuccess: (String schoolAdminID) async {
              context.read<DataStoreService>().addSchool(
                  schoolAdminID,
                  _schoolName.text.trim(),
                  _City.text.trim(),
                  _Address.text.trim());
            },
            OnFaliure: (String error) async {
              print("OnFailed " + error);
              return null;
            });
        EasyLoading.dismiss();
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        print("Error Registering Nursery- " + e.toString());
      }
    }
    print("for is not valied " + formKey.currentState!.validate().toString());
    return null;
  }
}
