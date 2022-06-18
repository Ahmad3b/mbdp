import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mbdp/UserTypes.dart';
import 'package:provider/provider.dart';

import '../Const.dart';
import '../Models/userAccountModel.dart';
import 'AuthenticationService.dart';

class DataStoreService {
  final FirebaseFirestore _firestore;

  DataStoreService(this._firestore);

  Future<void> registerUserAccount(
      {required BuildContext context,
      required userAccountModel userSignupData,
      required Future<void> OnSuccess(String userID),
      required Future<void> OnFaliure(String errorMessage)}) async {
    try {
      UserCredential? result = await context
          .read<AuthenticationService>()
          .registerUser(
              email: userSignupData.Email,
              password: "123456",
              userType: UserTypes.values[userSignupData.UserType],
              FullName: userSignupData.FullName);

      if (result != null) {
        print("Account Registered");
        CollectionReference users =
            _firestore.collection(Const.UsersCollection);
        //SchoolId
        await users
            .doc(result.user!.uid)
            .set(userSignupData.toJson())
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        await OnSuccess(result.user!.uid);
      }
    } catch (e) {
      print("Account Register Failed " + e.toString());
      await OnFaliure(e.toString());
    }
  }

  Future<void> addSchool(
      String schoolId, String Name, String City, String Address) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.SchoolsCollection);
    SchoolsCollection.doc(schoolId)
        .set({"Name": Name, "City": City, "Address": Address})
        .then((value) => print("School Added to Db"))
        .catchError((erro) => print("Error Adding School to Db"));
  }

  Future<void> addParent(String ParentAuthID, String FullName, String Email,
      String Phone, String City, String Address) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.ParentsCollection);
    SchoolsCollection.doc(ParentAuthID)
        .set({
          "FullName": FullName,
          "Email": Email,
          "Phone": Phone,
          "City": City,
          "Address": Address
        })
        .then((value) => print("Parent Account Added to Db"))
        .catchError((erro) => print("Error Adding Parent Account to Db"));
  }

  Future<void> addChild(String ParentAuthID, String Name, int Age,
      int GradeLevel, String NationalId, List<int>? imgBytes) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.ParentsCollection);
    SchoolsCollection.doc(ParentAuthID)
        .collection(Const.ParentChildrensCollection)
        .add({
          "Name": Name,
          "Age": Age,
          "GradeLevel": GradeLevel,
          "NationalId": NationalId,
          "AvatarImg": imgBytes == null ? "" : base64Encode(imgBytes)
        })
        .then((value) => print("Child Account Added to Db"))
        .catchError((erro) => print("Error Adding Parent Account to Db"));
  }

  Future<void> registerChildInSchool(
      String ParentId,
      String ChildId,
      Map<String, dynamic> ChildData,
      String SchoolId,
      String SchoolName) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.SchoolsCollection);

    SchoolsCollection.doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .doc(ChildId)
        .set({
          "Name": ChildData["Name"],
          "Age": ChildData["Age"],
          "GradeLevel": ChildData["GradeLevel"],
          "NationalId": ChildData["NationalId"],
          "IsAccepted": false,
          "AvatarImg": ChildData["AvatarImg"]
        })
        .then((value) => print("Child Account Added to Db"))
        .catchError((erro) => print("Error Adding Parent Account to Db"));

    _firestore
        .collection(Const.ParentsCollection)
        .doc(ParentId)
        .collection(Const.ParentChildrensCollection)
        .doc(ChildId)
        .set({"SchoolId": SchoolId, "SchoolName": SchoolName},
            SetOptions(merge: true));
  }

  Future<void> approveRegisterChildInSchool(String SchoolId, String ChildId,
      Map<String, dynamic> ChildData, String TeacherId, String DriverId) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.SchoolsCollection);

    SchoolsCollection.doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .doc(ChildId)
        .set({"IsAccepted": true, "TeacherId": TeacherId, "DriverId": DriverId},
            SetOptions(merge: true))
        .then((value) => print("Child Accepted in the School"))
        .catchError(
            (erro) => print("Failed to accept the Child in the School"));
  }

  Future<void> addTeacher(String schoolId, String TeacherAccountID,
      String FullName, String Email) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.SchoolsCollection);

    _firestore
        .collection(Const.UsersCollection)
        .doc(TeacherAccountID)
        .set({"SchoolId": schoolId}, SetOptions(merge: true))
        .then((value) => print("Drvier Profile Updated"))
        .catchError((erro) => print("Error updating Drvier profile"));

    SchoolsCollection.doc(schoolId)
        .collection(Const.SchoolTeachersCollection)
        .doc(TeacherAccountID)
        .set({"FullName": FullName, "Email": Email, "SchoolId": schoolId})
        .then((value) => print("Teacher Added to Db"))
        .catchError((erro) => print("Error Adding Teacher to Db"));
  }

  Future<void> addDriver(String schoolId, String driverAccountId,
      String FullName, String Email) async {
    CollectionReference SchoolsCollection =
        _firestore.collection(Const.SchoolsCollection);

    _firestore
        .collection(Const.UsersCollection)
        .doc(driverAccountId)
        .set({"SchoolId": schoolId}, SetOptions(merge: true))
        .then((value) => print("Drvier Profile Updated"))
        .catchError((erro) => print("Error updating Drvier profile"));

    SchoolsCollection.doc(schoolId)
        .collection(Const.SchoolDriversCollection)
        .doc(driverAccountId)
        .set({"FullName": FullName, "Email": Email, "SchoolId": schoolId})
        .then((value) => print("Drvier Added to Db"))
        .catchError((erro) => print("Error Adding Drvier to Db"));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDriverUserProfile(
      String DriverId) async {
    print("get Dirver Profie " + DriverId);
    var doc =
        await _firestore.collection(Const.UsersCollection).doc(DriverId).get();
    return doc;
  }

  Future<DocumentSnapshot<Object?>> getTeacherUserProfile(
      String TeacherId) async {
    return _firestore.collection(Const.UsersCollection).doc(TeacherId).get();
  }

  Stream<QuerySnapshot> getTeachersList(String SchoolID) {
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolID)
        .collection(Const.SchoolTeachersCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> getMyChildrenList(String ParentID) {
    return _firestore
        .collection(Const.ParentsCollection)
        .doc(ParentID)
        .collection(Const.ParentChildrensCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolUnapprovedChildrenList(String SchoolId) {
    print("School Unapproved ChildrenList " + SchoolId);
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .where("IsAccepted", isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolApprovedChildrenList(String SchoolId) {
    print("School Unapproved ChildrenList " + SchoolId);
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .where("IsAccepted", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolChildrenListByDriverId(
      String SchoolId, String DriverId) {
    print("School Driver ChildrenList " + DriverId);
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .where("DriverId", isEqualTo: DriverId)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolChildrenListByTeacherId(
      String SchoolId, String TeacherId) {
    print("School Teacher  ChildrenList " + TeacherId);
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolId)
        .collection(Const.SchoolStudentCollection)
        .where("TeacherId", isEqualTo: TeacherId)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolsList(String ParentID) {
    return _firestore.collection(Const.SchoolsCollection).snapshots();
  }

  Stream<QuerySnapshot> getDriversList(String SchoolID) {
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolID)
        .collection(Const.SchoolDriversCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> getSchoolPhotoGallery(String SchoolID) {
    return _firestore
        .collection(Const.SchoolsCollection)
        .doc(SchoolID)
        .collection(Const.SchoolPhotoGallery)
        .snapshots();
  }

  Future<void> addPhotoToGallery(String schoolId, List<int>? imgBytes) async {
    _firestore
        .collection(Const.SchoolsCollection)
        .doc(schoolId)
        .collection(Const.SchoolPhotoGallery)
        .add({"Img": imgBytes == null ? "" : base64Encode(imgBytes)})
        .then((value) => print("School Image Hass been Added to Db"))
        .catchError((erro) => print("Error Adding School Image to Db"));
  }
}
