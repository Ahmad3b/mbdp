import 'package:json_annotation/json_annotation.dart';

part 'userAccountModel.g.dart';

@JsonSerializable(explicitToJson: true)
class userAccountModel {
  final String UserName;
  final String FullName;
  final String Email;
  final String PhoneNumber;
  int UserType;

  @JsonKey(ignore: true)
  final String? Password;

  userAccountModel(
      {required this.UserName,
      required this.FullName,
      this.Password,
      required this.Email,
      required this.PhoneNumber,
      required this.UserType});

  factory userAccountModel.fromJson(Map<String, dynamic> json) =>
      _$userAccountModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$userAccountModelToJson(this); //Replace 'Person' with your class name

}
