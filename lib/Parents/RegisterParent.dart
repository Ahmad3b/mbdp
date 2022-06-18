import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/Parents/ParentsHome.dart';
import 'package:provider/provider.dart';

import '../Controls/CustomButton.dart';
import '../Controls/CustomTextEntryField.dart';
import '../Models/userAccountModel.dart';
import '../Services/AuthenticationService.dart';
import '../Services/DataStoreService.dart';
import '../UserTypes.dart';

class RegisterParent extends StatefulWidget {
  @override
  _RegisterParentState createState() => _RegisterParentState();
}

class _RegisterParentState extends State<RegisterParent> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _parentFullName = TextEditingController();
  TextEditingController _parentEmail = TextEditingController();
  TextEditingController _parentPassword = TextEditingController();
  TextEditingController _parentConfirmPassword = TextEditingController();
  TextEditingController _parentCity = TextEditingController();
  TextEditingController _parentAddress = TextEditingController();
  TextEditingController _parentPhone = TextEditingController();

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
                    'Register Parent',
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
                            hintText: 'Full Name',
                            inptcontroller: _parentFullName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Username
                          CustomTextEntryField(
                            hintText: 'Email',
                            inptcontroller: _parentEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Phone
                          CustomTextEntryField(
                            hintText: 'Phone',
                            isPassword: false,
                            inptcontroller: _parentPhone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Passsword
                          CustomTextEntryField(
                            hintText: 'Password',
                            isPassword: true,
                            inptcontroller: _parentPassword,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Confirm Password
                          CustomTextEntryField(
                            hintText: 'Confirm Password',
                            isPassword: true,
                            inptcontroller: _parentConfirmPassword,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          CustomTextEntryField(
                            hintText: 'City',
                            inptcontroller: _parentCity,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          CustomTextEntryField(
                            hintText: 'Address',
                            inptcontroller: _parentAddress,
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
                                  registerSchool();
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
                UserName: _parentEmail.text.trim(),
                FullName: _parentFullName.text.trim(),
                Email: _parentEmail.text.trim(),
                PhoneNumber: _parentPhone.text.trim(),
                UserType: UserTypes.Parent.index),
            OnSuccess: (String parentAuthId) async {
              context.read<DataStoreService>().addParent(
                    parentAuthId,
                    _parentFullName.text.trim(),
                    _parentEmail.text.trim(),
                    _parentPhone.text.trim(),
                    _parentCity.text.trim(),
                    _parentAddress.text.trim(),
                  );
            },
            OnFaliure: (String error) async {
              print("OnFailed " + error);
              return null;
            });
        EasyLoading.dismiss();
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        print("Error Registering school - " + e.toString());
      }
    }
    print("for is not valied " + formKey.currentState!.validate().toString());
  }
}
