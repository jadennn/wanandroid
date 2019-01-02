import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Articles.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//收藏页
class CollectionArticlesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionArticlesPageState();
  }
}

class CollectionArticlesPageState extends State<CollectionArticlesPage>
    with AutomaticKeepAliveClientMixin {
  final _articles = <Article>[];
  int _page = 0;
  final _titleFont = const TextStyle(fontSize: 18.0, color: Colors.black);
  final _descFont = const TextStyle(fontSize: 12.0, color: Colors.blueGrey);

  @override
  void initState() {
    _getArticles(page: _page++);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.length <= 0) {
      return Center(
        child: Text("加载中..."),
      );
    } else {
      return SafeArea(
        top: true,
        child: MaterialApp(
          home: buildArticles(),
        ),
      );
    }
  }

  //单个item的绘制
  Widget _buildRow(Article article, int index) {
    return ListTile(
      title: Text(
        article.title,
        maxLines: 1,
        style: _titleFont,
      ),
      subtitle: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Text(
                article.author,
              ),
            ),
            Icon(
              Icons.access_time,
              size: 15,
            ),
            Text(article.niceDate),
          ],
        ),
      ),
      trailing: GestureDetector(
        child: new Icon(
          Icons.favorite,
          color: Colors.redAccent,
        ),
        onTap: () {
          _cancelCollection(article, index);
        },
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return new SafeArea(
              top: true,
              child: WebviewScaffold(
                url: article.link,
              ));
        }));
      },
    );
  }

  //组合收藏列表成为一个ListView
  Widget buildArticles() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: _articles.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _articles.length) {
            _getArticles(page: _page++);
          }
          return _buildRow(_articles[index], index);
        });
  }

  //获取收藏的文章列表
  void _getArticles({int page = 0}) async {
    Result result = await NetManager.getInstance()
        .request("/lg/collect/list/$page/json", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      setState(() {
        Articles articles = Articles.fromJson(result.data);
        _articles.addAll(articles.datas);
      });
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //取消收藏
  void _cancelCollection(Article article, int index) async {
    Result result = await NetManager.getInstance().request(
        "/lg/uncollect/${article.id}/json",
        "originId=${article.originId == null ? -1 : article.originId}",
        Options(
          method: "POST",
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ));
    if (result.errorCode == 0) {
      ToastUtil.showTips("取消收藏成功");
      _articles.removeAt(index);
    } else {
      ToastUtil.showError(result.errorMsg);
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => false;
}
