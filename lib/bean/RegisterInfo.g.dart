// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInfo _$RegisterInfoFromJson(Map<String, dynamic> json) {
  return RegisterInfo(json['username'] as String, json['password'] as String,
      json['repassword'] as String);
}

Map<String, dynamic> _$RegisterInfoToJson(RegisterInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'repassword': instance.repassword
    };
