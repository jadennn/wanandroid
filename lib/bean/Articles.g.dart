// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) {
  return Articles(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : Article.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ArticlesToJson(Articles instance) =>
    <String, dynamic>{'curPage': instance.curPage, 'datas': instance.datas};
