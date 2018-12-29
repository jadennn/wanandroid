import 'package:flutter/material.dart';
import 'package:wanandroid/bean/UserInfo.dart';
import 'package:wanandroid/page/ArticlesPage.dart';
import 'package:wanandroid/page/CollectionArticlesPage.dart';
import 'package:wanandroid/page/NavigationPage.dart';
import 'package:wanandroid/page/NavigationWidget.dart';
import 'package:wanandroid/page/ProjectPage.dart';
import 'package:wanandroid/page/SettingPage.dart';

//主页
class HomePage extends StatefulWidget {
  final UserInfo userInfo;

  const HomePage({Key key, @required this.userInfo});

  @override
  State<StatefulWidget> createState() {
    return new HomePageState(userInfo);
  }
}

class HomePageState extends State<HomePage>{
  int _page = 0;
  final UserInfo userInfo;

  HomePageState(this.userInfo);

  final PageController pageController = new PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          children: <Widget>[
            ArticlesPage(),
            ProjectPage(),
            NavigationPage(),
            CollectionArticlesPage(),
          ],
          onPageChanged: changePage,
        ),
        bottomNavigationBar: Navigations(_page, changePage),
      drawer: Drawer(
        child: SettingPage(userInfo),
      ),
    );
  }

  void changePage(int page) {
    if (_page != page) {
      setState(() {
        _page = page;
        pageController.jumpToPage(_page);
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
