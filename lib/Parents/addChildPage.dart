import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Controls/CustomButton.dart';
import '../Controls/CustomTextEntryField.dart';
import '../Models/userAccountModel.dart';
import '../Services/AuthenticationService.dart';
import '../Services/DataStoreService.dart';
import '../UserTypes.dart';
import 'package:image_picker/image_picker.dart';

class addChildPage extends StatefulWidget {
  @override
  _addChildPageState createState() => _addChildPageState();
}

class _addChildPageState extends State<addChildPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _Name = TextEditingController();
  TextEditingController _Age = TextEditingController();
  TextEditingController _GradeLevel = TextEditingController();
  TextEditingController _NationalId = TextEditingController();
  File? _image;
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
                    'Child Details',
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
                          CustomButton(
                            margin: 2,
                            ButtonLabel: 'Photo',
                            onPressed: () async {
                              chooseFile();
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //Child Name
                          CustomTextEntryField(
                            hintText: 'Name',
                            inptcontroller: _Name,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Age
                          CustomTextEntryField(
                            hintText: 'Age',
                            inptcontroller: _Age,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Grade Level
                          CustomTextEntryField(
                            hintText: 'Grade Level',
                            isPassword: false,
                            keyboardType: TextInputType.number,
                            inptcontroller: _GradeLevel,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Passsword
                          CustomTextEntryField(
                            hintText: 'NationalId',
                            isPassword: false,
                            inptcontroller: _NationalId,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                margin: 2,
                                ButtonLabel: 'Register',
                                onPressed: () async {
                                  addChild();
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

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future<void> addChild() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        await context.read<DataStoreService>().addChild(
            context.read<AuthenticationService>().credential!.user!.uid,
            _Name.text.trim(),
            int.parse(_Age.text.trim()),
            int.parse(_GradeLevel.text.trim()),
            _NationalId.text.trim(),
            _image == null ? null : _image!.readAsBytesSync());
        EasyLoading.dismiss();
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        print("Error Registering Nursery - " + e.toString());
      }
    }
    print("for is not valied " + formKey.currentState!.validate().toString());
  }
}
