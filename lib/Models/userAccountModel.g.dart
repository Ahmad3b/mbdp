// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userAccountModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

userAccountModel _$userAccountModelFromJson(Map<String, dynamic> json) =>
    userAccountModel(
      UserName: json['UserName'] as String,
      FullName: json['FullName'] as String,
      Email: json['Email'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      UserType: json['UserType'] as int,
    );

Map<String, dynamic> _$userAccountModelToJson(userAccountModel instance) =>
    <String, dynamic>{
      'UserName': instance.UserName,
      'FullName': instance.FullName,
      'Email': instance.Email,
      'PhoneNumber': instance.PhoneNumber,
      'UserType': instance.UserType,
    };
