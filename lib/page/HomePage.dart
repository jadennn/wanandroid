import 'package:flutter/material.dart';
import 'package:wanandroid/bean/UserInfo.dart';
import 'package:wanandroid/page/ArticlesPage.dart';
import 'package:wanandroid/page/CollectionArticlesPage.dart';

class HomePage extends StatelessWidget{
  UserInfo userInfo;
  HomePage({Key key, @required this.userInfo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: PageView(
        children: <Widget>[
          ArticlesPage(),
          page2(),
          page3(),
          CollectionArticlesPage(),
        ],
      )
    );
  }
}

class page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
        child: Text("page1"),
      ),
    );
  }

}

class page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
        child: Text("page2"),
      ),
    );
  }

}

class page3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
        child: Text("page3"),
      ),
    );
  }

}

class page4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
        child: Text("page4"),
      ),
    );
  }

}