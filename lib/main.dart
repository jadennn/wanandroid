import 'package:flutter/material.dart';
import 'package:wanandroid/page/LoginPage.dart';

void main() {
  runApp(Page());
}

class Page extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "sss",
      home: LoginPage(),
    );
  }

}

