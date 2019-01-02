import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid/page/LoginPage.dart';

void main() {
  runApp(Page());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.blueGrey);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class Page extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "wanandroid",
      home: LoginPage(),
    );
  }

}

