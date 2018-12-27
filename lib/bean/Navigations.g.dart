// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Navigations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Navigations _$NavigationsFromJson(Map<String, dynamic> json) {
  return Navigations(
      (json['articles'] as List)
          ?.map((e) =>
              e == null ? null : Article.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['cid'] as int,
      json['name'] as String);
}

Map<String, dynamic> _$NavigationsToJson(Navigations instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name
    };
