import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbdp/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

import '../../Controls/CustomButton.dart';
import '../../Controls/CustomTextEntryField.dart';
import '../../Models/userAccountModel.dart';
import '../../Services/DataStoreService.dart';
import '../../UserTypes.dart';

class AddDriverPage extends StatefulWidget {
  @override
  _AddDriverPageState createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _fullName = new TextEditingController();
  TextEditingController _Email = new TextEditingController();
  TextEditingController _Password = new TextEditingController();
  TextEditingController _Phone = new TextEditingController();

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
                    'Driver Information',
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
                            inptcontroller: _fullName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Username
                          CustomTextEntryField(
                            hintText: 'Email',
                            inptcontroller: _Email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Passsword
                          CustomTextEntryField(
                            hintText: 'Password',
                            isPassword: true,
                            inptcontroller: _Password,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                margin: 2,
                                ButtonLabel: 'Add',
                                onPressed: () async {
                                  registerDriver();
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                margin: 2,
                                ButtonLabel: 'Cancel',
                                onPressed: () async {
                                  Navigator.pop(context);
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

  Future<void> registerDriver() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        await context.read<DataStoreService>().registerUserAccount(
            context: context,
            userSignupData: userAccountModel(
                UserName: _Email.text.trim(),
                FullName: _fullName.text.trim(),
                Email: _Email.text.trim(),
                PhoneNumber: _Phone.text.trim(),
                UserType: UserTypes.SchoolDriver.index),
            OnSuccess: (String teacherAuthId) async {
              context.read<DataStoreService>().addDriver(
                  context.read<AuthenticationService>().credential!.user!.uid,
                  teacherAuthId,
                  _fullName.text.trim(),
                  _Email.text.trim());
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
