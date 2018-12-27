import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/bean/ProjectCategory.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//项目页
class ProjectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }

}

class ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin{
  final _projectCategoryList = <ProjectCategory>[];

  TabController _tabController;

  @override
  void initState() {
    _getProjectCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(length: _projectCategoryList.length, vsync: this);
    return SafeArea(
      top: true,
      child: createCategoryItem(),
    );
  }

  //创建类别
  Widget createCategoryItem(){
    List<Widget> categorys = new List();
    for(ProjectCategory category in _projectCategoryList){
      categorys.add(
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 20),
            child:OutlineButton(
              onPressed: (){},
              child: Text(category.name),
            ),
          )
      );
    }
    return  TabBar(
      isScrollable: true,
      tabs: categorys,
      controller: _tabController,);
  }

  //获取项目分类
  void _getProjectCategoryList() async {
    Result  result = await NetManager.getInstance().request("/project/tree/json", null, Options(
        method: "GET"));
    if(result.errorCode == 0){
      List<ProjectCategory> projectCategoryList = _parseToList(result.data);
      if(projectCategoryList != null) {
        setState(() {
          _projectCategoryList.clear();
          _projectCategoryList.addAll(projectCategoryList);
          for(ProjectCategory category in _projectCategoryList){
            print(category.name);
          }
        });
      }
    }else{
      ToastUtil.showError(result.errorMsg);
    }
  }


  //将data解析为Navigations数组
  List<ProjectCategory> _parseToList(dynamic data){
    return (data as List)
        ?.map((e) =>
    e == null ? null : ProjectCategory.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }


}