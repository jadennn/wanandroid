
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/bean/RegisterInfo.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/util/ToastUtil.dart';

//注册页
class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  String _username = "123";
  String _password = "123";
  String _repassword = "123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(Icons.blur_circular),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 80),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "账号"
                        ),
                        onChanged: _onUsernameChanged,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "密码",
                        ),
                        obscureText: true,
                        onChanged: _onPasswordChanged,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "确认密码",
                        ),
                        obscureText: true,
                        onChanged: _onRePasswordChanged,
                      ),
                      Container(
                        child: FlatButton(
                            color: Colors.blueGrey,
                            textColor: Colors.white,
                            onPressed: _registerOnPressed,
                            child: Text("注册")),
                        width: 2000,
                        margin: EdgeInsets.only(top: 30),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }

  void _onUsernameChanged(String username) {
    _username = username;
  }

  void _onPasswordChanged(String password) {
    _password = password;
  }

  void _onRePasswordChanged(String password) {
    _repassword = password;
  }

  //注册
  void _registerOnPressed() async{
    RegisterInfo ri = new RegisterInfo(_username, _password, _repassword);
    Result  result = await NetManager.getInstance().request("/user/register", ri.toKeyValue(), Options(
        method: "POST",
        contentType: ContentType.parse("application/x-www-form-urlencoded")) );
    if(result.errorCode == 0){
      ToastUtil.showTips("注册成功");
      Navigator.pop(context, _username);
    }else {
      ToastUtil.showError(result.errorMsg);
    }
  }

}
