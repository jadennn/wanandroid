import 'package:json_annotation/json_annotation.dart';

part 'UserInfo.g.dart';

@JsonSerializable()

class UserInfo{
  UserInfo(this.chapterTops, this.collectIds, this.email, this.icon, this.id, this.password, this.token, this.type, this.username);
  dynamic chapterTops;
  dynamic collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}