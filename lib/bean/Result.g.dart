// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['errorCode'] as int, json['errorMsg'] as String, json['data']);
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };
