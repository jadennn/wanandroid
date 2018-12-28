import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Articles.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/bean/ProjectCategory.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//项目页
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  final _projectCategoryList = <ProjectCategory>[];
  TabController _tabController;
  final _articles = <Article>[];
  final _titleFont = const TextStyle(
      fontSize: 18.0,
      color: Colors.black);
  final _descFont = const TextStyle(
      fontSize: 12.0,
      color: Colors.grey
  );
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
    _tabController = new TabController(length: _projectCategoryList.length, vsync: this);
    return createCategoryItem();
  }

  //创建类别
  Widget createCategoryItem() {
    List<Widget> categorys = new List();
    for (ProjectCategory category in _projectCategoryList) {
      categorys.add(
        Tab(
        child: Text(category.name),
        ),);
    }
    _tabController.addListener((){
      if(_tabController.index != _tabIndex){
        _articles.clear();
        _tabIndex = _tabController.index;
        _cid = _projectCategoryList[_tabIndex].id;
        _page = 1;
        _getProjectsByCategory(_cid, page: _page);
      }
    });
    _tabController.index = _tabIndex;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: TabBar(
          controller: _tabController,
          tabs: categorys,
        indicatorColor: Colors.white,
        isScrollable: true,),
      ),
      body: buildArticles(),
    );
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
  void _getProjectsByCategory(cid, {int page=1}) async{
    Result result = await NetManager.getInstance()
        .request("/project/list/$page/json?cid=$cid", null, Options(method: "GET"));
    if(result.errorCode == 0){
      setState(() {
        Articles articles = Articles.fromJson(result.data);
        _articles.addAll(articles.datas);
      });
    }else{
      ToastUtil.showError(result.errorMsg);
    }
  }

  //组合item成为一个ListView
  Widget buildArticles(){
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: _articles.length * 2,
        itemBuilder: (BuildContext context, int i){
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          if(index >= _articles.length - 1){
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
        style: _titleFont,),
      subtitle: Text(
        article.desc,
        maxLines: 1,
        style: _descFont,
      ),
      trailing: new Icon(
        article.collect ? Icons.favorite : Icons.favorite_border,
        color: article.collect ? Colors.red : null,
      ),
      onTap: (){
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
