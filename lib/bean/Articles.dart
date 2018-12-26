

import 'package:wanandroid/bean/Article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Articles.g.dart';

@JsonSerializable()

class Articles{
  int curPage;
  List<Article> datas;

  Articles(
      this.curPage,
      this.datas
      );

  factory Articles.fromJson(Map<String, dynamic> json) => _$ArticlesFromJson(json);
}