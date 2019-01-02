import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/bean/LoginInfo.dart';
import 'package:wanandroid/bean/UserInfo.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/page/HomePage.dart';
import 'package:wanandroid/page/LoadingDialog.dart';
import 'package:wanandroid/page/RegisterPage.dart';
import 'package:wanandroid/util/ToastUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

//登录页
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  static String USERNAME = "username";
  static String PASSWORD = "password";

  String _version = "";
  String _username = "";
  String _password = "";

  @override
  void initState() {
    _init();
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage("images/logo.png"),
            height: 100,
            width: 100,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 80),
          child: Column(
            children: <Widget>[
              TextField(
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: _username,
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _username == null ? 0 : _username.length)))),
                decoration: InputDecoration(labelText: "账号"),
                onChanged: _onUsernameChanged,
              ),
              TextField(
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: _password,
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _password == null ? 0 : _password.length)))),
                decoration: InputDecoration(
                  labelText: "密码",
                ),
                obscureText: true,
                onChanged: _onPasswordChanged,
              ),
              Container(
                child: FlatButton(
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    onPressed: _loginOnPressed,
                    child: Text("登陆")),
                width: 2000,
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      return new RegisterPage();
                    })).then((value) {
                      setState(() {
                        if (value != null) {
                          _username = value;
                        }
                      });
                    });
                  },
                  child: Text(
                    "注册账号",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                margin: EdgeInsets.only(top: 10),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text("v" + _version),
        )
      ],
    )));
  }

  void _onUsernameChanged(String username) {
    _username = username;
  }

  void _onPasswordChanged(String password) {
    _password = password;
  }

  void _loginOnPressed() async {
    LoadingDialog dialog = LoadingDialog();
    dialog.show(context);
    LoginInfo li = new LoginInfo(_username, _password);
    Result result = await NetManager.getInstance().request(
        "/user/login",
        li.toKeyValue(),
        Options(
            method: "POST",
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    dialog.dismiss(context);
    if (result.errorCode == 0) {
      ToastUtil.showTips("登陆成功");
      _save();
      Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(
              builder: (context) {
                return new HomePage(userInfo: UserInfo.fromJson(result.data));
              },),
              (route) => route == null);
    } else {
      _clear();
      ToastUtil.showError(result.errorMsg);
    }
  }

  //获取已经登录的账号和密码
  void _load() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    _username = sp.getString(USERNAME) == null ? "" : sp.getString(USERNAME);
    _password = sp.getString(PASSWORD) == null ? "" : sp.getString(PASSWORD);
  }

  //保存账号密码
  void _save() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USERNAME, _username);
    sp.setString(PASSWORD, _password);
  }

  //登录失败，清除保存的账号密码
  void _clear(){
    setState(() {
      _password = "";
    });
    _save();
  }

  //获取版本号
  void _init() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _version = packageInfo.version;
      });
    });
  }
}
