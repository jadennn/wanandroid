import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Articles.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/util/ToastUtil.dart';
import 'package:wanandroid/bean/Banner.dart' as bean;

//文章页
class ArticlesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticlesPageState();
  }
}

class ArticlesPageState extends State<ArticlesPage>
    with AutomaticKeepAliveClientMixin {
  final _articles = <Article>[];
  final _banners = <bean.Banner>[];
  int _page = 0;

  final _titleFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  void initState() {
    _getArticles(page: _page++);
    _getBanners();
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
        child: Scaffold(
          body: Column(
            children: <Widget>[
              _banners.length == 0
                  ? Image.network(
                      "http://www.wanandroid.com/blogimgs/ab17e8f9-6b79-450b-8079-0f2287eb6f0f.png")
                  : Container(
                      height: 200,
                      width: double.infinity,
                      child: BannerView(
                        buildBanners(),
                        intervalDuration: Duration(seconds: 3),
                      ),
                    ),
              Expanded(
                child: buildArticles(),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<Widget> buildBanners() {
    List<Widget> list = new List();
    for (bean.Banner banner in _banners) {
      list.add(GestureDetector(
        child: Image.network(
          banner.imagePath,
        ),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return new SafeArea(
                top: true,
                child: WebviewScaffold(
                  url: banner.url,
                ));
          }));
        },
      ));
    }
    return list;
  }

  //组合item成为一个ListView
  Widget buildArticles() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: _articles.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return new Divider(
              color: Colors.blueGrey,
            );
          }
          final index = i ~/ 2;
          if (index >= _articles.length - 1) {
            _getArticles(page: _page++);
          }
          return _buildRow(_articles[index], index);
        });
  }

  //单个item元素
  Widget _buildRow(Article article, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.white, offset: Offset(2.0, 2.0), blurRadius: 4.0)
        ],
      ),
      child: ListTile(
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
          child: Icon(
            article.collect ? Icons.favorite : Icons.favorite_border,
            color: article.collect ? Colors.redAccent : null,
          ),
          onTap: () {
            _collect(article, index);
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
      ),
    );
  }

  //获取首页Banner
  void _getBanners() async {
    Result result = await NetManager.getInstance()
        .request("/banner/json", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      setState(() {
        List<bean.Banner> banners = _parseToList(result.data);
        if (banners != null) {
          setState(() {
            _banners.clear();
            _banners.addAll(banners);
          });
        }
      });
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //将data解析为Navigations数组
  List<bean.Banner> _parseToList(dynamic data) {
    return (data as List)
        ?.map((e) =>
            e == null ? null : bean.Banner.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  //按页获取文章列表
  void _getArticles({int page = 0}) async {
    Result result = await NetManager.getInstance()
        .request("/article/list/$page/json", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      setState(() {
        Articles articles = Articles.fromJson(result.data);
        _articles.addAll(articles.datas);
      });
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //收藏，取消收藏
  void _collect(Article article, int index) async {
    if (article.collect) {
      Result result = await NetManager.getInstance().request(
          "/lg/uncollect_originId/${article.id}/json",
          null,
          Options(method: "POST"));
      if (result.errorCode == 0) {
        ToastUtil.showTips("取消收藏成功");
        article.collect = !article.collect;
        _articles.removeAt(index);
        _articles.insert(index, article);
        setState(() {});
      } else {
        ToastUtil.showError(result.errorMsg);
      }
    } else {
      Result result = await NetManager.getInstance().request(
          "/lg/collect/${article.id}/json", null, Options(method: "POST"));
      if (result.errorCode == 0) {
        ToastUtil.showTips("收藏成功");
        article.collect = !article.collect;
        _articles.removeAt(index);
        _articles.insert(index, article);
        setState(() {});
      } else {
        ToastUtil.showError(result.errorMsg);
      }
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => false;
}
