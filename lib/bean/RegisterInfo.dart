import 'package:json_annotation/json_annotation.dart';

part 'RegisterInfo.g.dart';

@JsonSerializable()

class RegisterInfo{
  RegisterInfo(this.username, this.password, this.repassword);

  String username;
  String password;
  String repassword;

  factory RegisterInfo.fromJson(Map<String, dynamic> json) => _$RegisterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);

  String toKeyValue(){
    return "username=$username&password=$password&repassword=$repassword";
  }

}