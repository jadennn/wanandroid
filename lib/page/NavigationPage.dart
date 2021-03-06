import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Navigations.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/locale/ProjectLocalizations.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/page/TopAreaWidget.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//导航页
class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigationPageState();
  }
}

class NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin {
  final _navigationsList = <Navigations>[];

  @override
  Widget build(BuildContext context) {
    if (_navigationsList.length <= 0) {
      return TopAreaWidget(child: Center(
        child: Text(ProjectLocalizations.of(context).loading),
      ),);
    } else {
      return TopAreaWidget(
        child: ListView(
          children: _createItems(),
        ),
      );
    }
  }

  @override
  void initState() {
    _getNavigations();
    super.initState();
  }

  //获取所有导航网站
  void _getNavigations() async {
    Result result = await NetManager.getInstance()
        .request("/navi/json", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      List<Navigations> navigationsList = _parseToList(result.data);
      if (navigationsList != null) {
        setState(() {
          _navigationsList.clear();
          _navigationsList.addAll(navigationsList);
        });
      }
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //将data解析为Navigations数组
  List<Navigations> _parseToList(dynamic data) {
    return (data as List)
        ?.map((e) =>
            e == null ? null : Navigations.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  List<Widget> _createItems() {
    List<Widget> navigations = <Widget>[];
    if (_navigationsList.length > 0) {
      for (Navigations n in _navigationsList) {
        navigations.add(Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                n.name,
                style: TextStyle(
                    fontSize: 20, color: Colors.redAccent, letterSpacing: 4),
              ),
            ),
            _createItem(n),
          ],
        ));
      }
    }
    return navigations;
  }

  Widget _createItem(Navigations navigation) {
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 3.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center,
      children: _crateItemChildren(navigation),
    );
  }

  List<Widget> _crateItemChildren(Navigations navigation) {
    List<Widget> articles = <Widget>[];
    Paint paint = new Paint();
    paint..color = Colors.blueGrey;
    for (Article article in navigation.articles) {
      articles.add(GestureDetector(
        child: Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blueGrey, child: Text(article.title[0])),
          label: Text(article.title),
        ),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return new TopAreaWidget(
                child: WebviewScaffold(
                  url: article.link,
//              appBar: AppBar(title: Text(article.title),
//              backgroundColor: Colors.blueGrey,
//            ),
                ));
          }));
        },
      ));
    }
    return articles;
  }

  @override
  bool get wantKeepAlive => false;
}
