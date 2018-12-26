import 'package:json_annotation/json_annotation.dart';

part 'LoginInfo.g.dart';

@JsonSerializable()

class LoginInfo{
  LoginInfo(this.username, this.password);

  String username;
  String password;

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);

  String toKeyValue(){
    return "username=$username&password=$password";
  }
}