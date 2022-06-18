import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/Controls/CustomButton.dart';
import 'package:mbdp/Parents/RegisterParent.dart';
import 'package:mbdp/Parents/SchoolPhotoGalary.dart';
import 'package:mbdp/Parents/addChildPage.dart';
import 'package:provider/provider.dart';

import '../Services/AuthenticationService.dart';
import '../Services/DataStoreService.dart';

class RegisterInSchool extends StatefulWidget {
  final Map<String, dynamic> child;
  final String childId;

  const RegisterInSchool({Key? key, required this.child, required this.childId})
      : super(key: key);

  @override
  _RegisterInSchoolState createState() => _RegisterInSchoolState();
}

class _RegisterInSchoolState extends State<RegisterInSchool> {
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
    final Stream<QuerySnapshot> _childrenList = context
        .read<DataStoreService>()
        .getSchoolsList(
            context.read<AuthenticationService>().credential!.user!.uid);

    return SafeArea(
      child: Scaffold(
          body: Container(
              width: double.infinity,
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
                  'Select Nursery',
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _childrenList,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.docs.length == 0)
                          return Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: double.maxFinite,
                            child: Text("There are no Nursery Defiend Yet."),
                          );
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SchoolPhotoGalary(
                                            SchoolName: data["Name"],
                                            SchoolId: document.id)))
                              },
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.lightBlue[100],
                                            child: (data['SchoolLogo'] !=
                                                        null &&
                                                    data['SchoolLogo'] != "")
                                                ? Image.memory(Base64Decoder()
                                                    .convert(
                                                        data['SchoolLogo']))
                                                : null,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text.rich(TextSpan(
                                                    text: 'Name : ',
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: data['Name'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ])),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text.rich(TextSpan(
                                                    text: 'City : ',
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: data['City'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ])),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text.rich(TextSpan(
                                                    text: 'Address : ',
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: data['Address'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ])),
                                              ],
                                            ),
                                          ),
                                        ),
                                        CustomButton(
                                          ButtonLabel: "Select",
                                          onPressed: () => {
                                            RegisterChildInScool(
                                                document.id, data["Name"])
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                            );
                            // ListTile(
                            //   title: Text(data['Name']),
                            //   onTap: () => {},
                            //   subtitle: Text(data['NationalId']),
                            // );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ]))),
    );
  }

  Future<void> RegisterChildInScool(String SchoolId, String SchoolName) async {
    EasyLoading.show();
    try {
      await context.read<DataStoreService>().registerChildInSchool(
          context
              .read<AuthenticationService>()
              .credential!
              .user!
              .uid, //ParentID
          widget.childId, // Child ID
          widget.child, // Child ID
          SchoolId, //School Id
          SchoolName);
      EasyLoading.dismiss();

      Navigator.pop(context);
    } catch (e) {
      EasyLoading.dismiss();
      print("Error Registering school - " + e.toString());
    }
  }
}
