import 'Article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Navigations.g.dart';

@JsonSerializable()

class Navigations{
  List<Article> articles;
  int cid;
  String name;

  Navigations(
      this.articles,
      this.cid,
      this.name,
      );

  factory Navigations.fromJson(Map<String, dynamic> json) => _$NavigationsFromJson(json);
}