import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbdp/NurserySchool/Teachers/TeachersListPage.dart';
import 'package:provider/provider.dart';

import '../Controls/CustomButton.dart';
import '../Services/AuthenticationService.dart';
import '../Services/DataStoreService.dart';

class RegisterStudentInSchool extends StatefulWidget {
  final Map<String, dynamic> child;
  final String childId;

  const RegisterStudentInSchool(
      {Key? key, required this.child, required this.childId})
      : super(key: key);

  @override
  _RegisterStudentInSchoolState createState() =>
      _RegisterStudentInSchoolState();
}

class _RegisterStudentInSchoolState extends State<RegisterStudentInSchool> {
  Timer? _timer;
  String? _TeacherId = "";
  String? _DriverId = "";

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
    final Stream<QuerySnapshot> _schoolTeachers = context
        .read<DataStoreService>()
        .getTeachersList(
            context.read<AuthenticationService>().credential!.user!.uid);

    final Stream<QuerySnapshot> _schoolDrivers = context
        .read<DataStoreService>()
        .getDriversList(
            context.read<AuthenticationService>().credential!.user!.uid);

    return SafeArea(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(198, 223, 223, 1),
              ),
              child: Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'))),
                ),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  'Select Teacher & Driver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(34, 73, 87, 1),
                      fontSize: 32,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      decoration: TextDecoration.none),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("Select Teacher"),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder(
                                stream: _schoolTeachers,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return snapshot.hasData
                                      ? DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 95, 203, 253),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 95, 203, 253),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                255, 95, 203, 253),
                                          ),
                                          dropdownColor:
                                              Color.fromARGB(255, 95, 203, 253),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _TeacherId = newValue;
                                            });
                                          },
                                          items: [
                                            for (var teacher
                                                in snapshot.data!.docs)
                                              DropdownMenuItem(
                                                  child:
                                                      Text(teacher["FullName"]),
                                                  value: teacher.id),
                                          ],
                                        )
                                      : Container();
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Select Driver"),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder(
                                stream: _schoolDrivers,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return snapshot.hasData
                                      ? DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 95, 203, 253),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 95, 203, 253),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                255, 95, 203, 253),
                                          ),
                                          dropdownColor:
                                              Color.fromARGB(255, 95, 203, 253),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _DriverId = newValue;
                                            });
                                          },
                                          items: [
                                            for (var driver
                                                in snapshot.data!.docs)
                                              DropdownMenuItem(
                                                  child:
                                                      Text(driver["FullName"]),
                                                  value: driver.id),
                                          ],
                                        )
                                      : Container();
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    margin: 2,
                                    ButtonLabel: 'Cancel',
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                    margin: 2,
                                    ButtonLabel: 'Save',
                                    onPressed: () async {
                                      await RegisterChildInScool();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]))),
    );
  }

  Future<void> RegisterChildInScool() async {
    EasyLoading.show();
    try {
      if (_TeacherId == null || _TeacherId == "") {
        print("You Have to select a Teacher and Driver");
        EasyLoading.dismiss();
        return;
      }
      await context.read<DataStoreService>().approveRegisterChildInSchool(
          context
              .read<AuthenticationService>()
              .credential!
              .user!
              .uid, //ParentID
          widget.childId, // Child ID
          widget.child, // Child ID
          _TeacherId!,
          _DriverId!);
      EasyLoading.dismiss();
      Navigator.pop(context);
    } catch (e) {
      EasyLoading.dismiss();
      print("Error Registering Nursery - " + e.toString());
    }
  }
}
