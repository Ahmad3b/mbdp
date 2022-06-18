import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'NurserySchool/NurseryDashboard.dart';

class templatePage extends StatefulWidget {
  @override
  _templatePageState createState() => _templatePageState();
}

class _templatePageState extends State<templatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ])));
  }
}
