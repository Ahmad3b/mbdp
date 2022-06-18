import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbdp/Parents/RegisterInSchool.dart';
import 'package:mbdp/Parents/RegisterParent.dart';
import 'package:mbdp/Parents/addChildPage.dart';
import 'package:provider/provider.dart';

import '../Services/AuthenticationService.dart';
import '../Services/DataStoreService.dart';

class ParentsHome extends StatefulWidget {
  @override
  _ParentsHomeState createState() => _ParentsHomeState();
}

class _ParentsHomeState extends State<ParentsHome> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _childrenList = context
        .read<DataStoreService>()
        .getMyChildrenList(
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
                    builder: (context) => addChildPage(),
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
                  'Children',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(34, 73, 87, 1),
                      fontSize: 32,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      decoration: TextDecoration.none),
                ),
                Container(
                  width: double.maxFinite,
                  height: 200,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _childrenList,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.length == 0)
                        return Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: double.maxFinite,
                          child: Text("There are no Defined Childrens"),
                        );

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return GestureDetector(
                            onLongPressDown: (details) => {},
                            onTap: () => {
                              if (data['NurseryName'] == null)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterInSchool(
                                            child: data, childId: document.id),
                                      ))
                                }
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
                                                    text: data['Name'],
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
                                                text: 'National Id : ',
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: data['NationalId'],
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
                                                text: 'School Name : ',
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: data['NurseryName'] ==
                                                            null
                                                        ? "Not Registered"
                                                        : data['NurseryName'],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            data['NurseryName'] ==
                                                                    null
                                                                ? Colors.red
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )
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
              ]))),
    );
  }
}
