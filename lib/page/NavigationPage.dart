import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Navigations.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//导航页
class NavigationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavigationPageState();
  }
}

class NavigationPageState extends State<NavigationPage>{
  final _navigationsList = <Navigations>[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: ListView(
        children: _createItems(),
      ),
    );
  }

  @override
  void initState() {
    _getNavigations();
    super.initState();
  }

  //获取所有导航网站
  void _getNavigations() async {
    Result  result = await NetManager.getInstance().request("/navi/json", null, Options(
        method: "GET"));
    if(result.errorCode == 0){
      List<Navigations> navigationsList = _parseToList(result.data);
      if(navigationsList != null) {
        setState(() {
          _navigationsList.clear();
          _navigationsList.addAll(navigationsList);
        });
      }
    }else{
      ToastUtil.showError(result.errorMsg);
    }
  }

  //将data解析为Navigations数组
  List<Navigations> _parseToList(dynamic data){
    return (data as List)
        ?.map((e) =>
    e == null ? null : Navigations.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  List<Widget> _createItems(){
    List<Widget> navigations = <Widget>[];
    if(_navigationsList.length > 0){
      for(Navigations n in _navigationsList){
        navigations.add(
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  n.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      letterSpacing: 4
                  ),
                ),
              ),
              _createItem(n),
            ],
          )
        );
      }
    }
    return navigations;
  }

  Widget _createItem(Navigations navigation){
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 3.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center,
      children: _crateItemChildren(navigation),
    );
  }

  List<Widget> _crateItemChildren(Navigations navigation){
    List<Widget> articles = <Widget>[];
    Paint paint = new Paint();
    paint..color = Colors.grey;
    for(Article article in navigation.articles){
      articles.add(
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text(article.title[0])),
          label: Text(article.title),
        ));
    }
    return articles;
  }

}