import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mbdp/Controls/CustomButton.dart';
import 'package:mbdp/NurserySchool/Teachers/AddTeacherPage.dart';
import 'package:mbdp/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

import '../../Services/DataStoreService.dart';

class TeachersListPage extends StatefulWidget {
  @override
  _TeachersListPageState createState() => _TeachersListPageState();
}

class _TeachersListPageState extends State<TeachersListPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _teachers = context
        .read<DataStoreService>()
        .getTeachersList(
            context.read<AuthenticationService>().credential!.user!.uid);

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            focusColor: Colors.green,
            elevation: 12,
            child: Text("+"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTeacherPage(),
                  ));
            },
          ),
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
                  'Teachers',
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
                    height: 200,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _teachers,
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
                            child: Text("There are no Defined Teachers"),
                          );

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Card(
                                child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.lightBlue[100],
                                          child: (data['AvatarImg'] != null &&
                                                  data['AvatarImg'] != "")
                                              ? Image.memory(Base64Decoder()
                                                  .convert(data['AvatarImg']))
                                              : null,
                                        ),
                                      ),
                                      Padding(
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
                                                    text: data['FullName'],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ])),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text.rich(TextSpan(
                                                text: 'Email : ',
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: data['Email'],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ])),
                                            SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ));
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ]))),
    );
  }
}
