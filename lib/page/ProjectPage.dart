import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Articles.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/bean/ProjectCategory.dart';
import 'package:wanandroid/page/TopAreaWidget.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//项目页
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _projectCategoryList = <ProjectCategory>[];
  TabController _tabController;
  final _articles = <Article>[];
  final _titleFont = const TextStyle(fontSize: 18.0, color: Colors.black);
  final _descFont = const TextStyle(fontSize: 12.0, color: Colors.blueGrey);
  int _tabIndex = 0;
  int _cid = 0;
  int _page = 1;

  @override
  void initState() {
    _getProjectCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabController =
        new TabController(length: _projectCategoryList.length, vsync: this);
    return createCategoryItem();
  }

  //创建类别
  Widget createCategoryItem() {
    List<Widget> categorys = new List();
    for (ProjectCategory category in _projectCategoryList) {
      categorys.add(
        Tab(
          child: Text(category.name),
        ),
      );
    }
    _tabController.addListener(() {
      if (_tabController.index != _tabIndex) {
        _articles.clear();
        _tabIndex = _tabController.index;
        _cid = _projectCategoryList[_tabIndex].id;
        _page = 1;
        _getProjectsByCategory(_cid, page: _page);
      }
    });
    _tabController.index = _tabIndex;

    if (_projectCategoryList.length <= 0 || _articles.length <= 0) {
      return TopAreaWidget(child: Center(
        child: Text("加载中..."),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
          title: TabBar(
            controller: _tabController,
            tabs: categorys,
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
        ),
        body: buildArticles(),
      );
    }
  }

  //获取项目分类
  void _getProjectCategoryList() async {
    Result result = await NetManager.getInstance()
        .request("/project/tree/json", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      List<ProjectCategory> projectCategoryList = _parseToList(result.data);
      if (projectCategoryList != null) {
        setState(() {
          _projectCategoryList.clear();
          _projectCategoryList.addAll(projectCategoryList);
          _cid = _projectCategoryList[0].id;
          _page = 1;
          _articles.clear();
          _getProjectsByCategory(_cid, page: _page);
        });
      }
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //将data解析为Project数组
  List<ProjectCategory> _parseToList(dynamic data) {
    return (data as List)
        ?.map((e) => e == null
            ? null
            : ProjectCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  //获取该分类的文章
  void _getProjectsByCategory(cid, {int page = 1}) async {
    Result result = await NetManager.getInstance().request(
        "/project/list/$page/json?cid=$cid", null, Options(method: "GET"));
    if (result.errorCode == 0) {
      setState(() {
        Articles articles = Articles.fromJson(result.data);
        _articles.addAll(articles.datas);
      });
    } else {
      ToastUtil.showError(result.errorMsg);
    }
  }

  //组合item成为一个ListView
  Widget buildArticles() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: _articles.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _articles.length - 1) {
            _getProjectsByCategory(_cid, page: _page++);
          }
          return _buildRow(_articles[index], index);
        });
  }

  //单个item元素
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
        onTap: () {
          _collect(article, index);
        },
        child: new Icon(
          article.collect ? Icons.favorite : Icons.favorite_border,
          color: article.collect ? Colors.red : null,
        ),
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return new TopAreaWidget(
              child: WebviewScaffold(
                url: article.link,
              ));
        }));
      },
    );
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}
