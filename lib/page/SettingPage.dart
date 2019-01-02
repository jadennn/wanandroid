import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bean/UserInfo.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/page/LoginPage.dart';

class SettingPage extends StatefulWidget {
  final UserInfo userInfo;

  const SettingPage(this.userInfo);

  @override
  State<StatefulWidget> createState() {
    return SettingPageState(userInfo);
  }
}

class SettingPageState extends State<SettingPage> {
  UserInfo userInfo;

  SettingPageState(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.all(40),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: "images/logo.png",
                        image: userInfo.icon,
                        fit: BoxFit.fitWidth,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    userInfo.username,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _quit();
                Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
                  builder: (context) {
                    return new LoginPage();
                  },
                ), (route) => route == null);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.exit_to_app),
                    ),
                    Text(
                      "退出当前账号",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _quit() async {
    await NetManager.getInstance()
        .request("/user/logout/json", null, Options(method: "GET"));
  }
}
