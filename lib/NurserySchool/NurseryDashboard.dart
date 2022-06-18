import 'package:flutter/material.dart';
import 'package:mbdp/NurserySchool/Drivers/DriversListPage.dart';
import 'package:mbdp/NurserySchool/PhotoLib/PhotoGalary.dart';
import 'package:mbdp/NurserySchool/Teachers/TeachersListPage.dart';
import 'package:mbdp/Students/StudentsHome.dart';

import 'NewlyRegisteredStudents.dart';

class NurseryDashboard extends StatefulWidget {
  @override
  _NurseryDashboardState createState() => _NurseryDashboardState();
}

class _NurseryDashboardState extends State<NurseryDashboard> {
  @override
  Widget build(BuildContext context) {
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
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(27, 212, 212, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Admin Panel',
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
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeachersListPage()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(34, 73, 87, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Teachers',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 212, 212, 1),
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DriversListPage()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(34, 73, 87, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Bus Drivers',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 212, 212, 1),
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewlyRegisteredStudents()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(34, 73, 87, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'New Applications',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 212, 212, 1),
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentsHome()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(34, 73, 87, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Students',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 212, 212, 1),
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoGallery()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(34, 73, 87, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Photo Gallery',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 212, 212, 1),
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]))),
    );
  }
}
