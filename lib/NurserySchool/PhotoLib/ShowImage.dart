import 'dart:convert';

import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  final String? ImgData;
  ShowImage({Key? key, this.ImgData}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
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
                  Expanded(
                      child: Image.memory(
                          Base64Decoder().convert(widget.ImgData!))),
                ]))));
  }
}
