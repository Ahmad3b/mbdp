import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbdp/NurserySchool/PhotoLib/ShowImage.dart';
import 'package:provider/provider.dart';

import '../../Services/DataStoreService.dart';

class SchoolPhotoGalary extends StatefulWidget {
  final String SchoolId;
  final String SchoolName;
  SchoolPhotoGalary(
      {Key? key, required this.SchoolId, required this.SchoolName})
      : super(key: key);

  @override
  State<SchoolPhotoGalary> createState() => _SchoolPhotoGalaryState();
}

class _SchoolPhotoGalaryState extends State<SchoolPhotoGalary> {
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
    final Stream<QuerySnapshot> _gallery =
        context.read<DataStoreService>().getSchoolPhotoGallery(widget.SchoolId);

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
                Text(
                  widget.SchoolName + " Photos",
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
                      stream: _gallery,
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
                            child: Text("There are no Defined Drivers"),
                          );

                        return Wrap(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowImage(ImgData: data['Img'])))
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child:
                                    (data['Img'] != null && data['Img'] != "")
                                        ? Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Image.memory(Base64Decoder()
                                                .convert(data['Img'])),
                                          )
                                        : null,
                              ),
                            );
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
