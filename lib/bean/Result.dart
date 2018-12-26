import 'package:json_annotation/json_annotation.dart';

part 'Result.g.dart';

@JsonSerializable()

class Result{
  Result(this.errorCode, this.errorMsg, this.data);

  int errorCode;
  String errorMsg;
  dynamic data;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

}