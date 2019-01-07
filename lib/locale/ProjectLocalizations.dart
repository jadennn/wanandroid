import 'dart:ui';

import 'package:flutter/widgets.dart';

class ProjectLocalizations{
  final Locale locale;

  ProjectLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    "en" : {
      "net error" : "net error",
      "loading" : "loading...",
      "collect success" : "collect success",
      "cancel collect success" : "cancel collect success",
      "account" : "account",
      "password" : "password",
      "login" : "login",
      "register" : "register",
      "login success" : "login success",
      "collection" : "collection",
      "article" : "article",
      "project" : "project",
      "navigation" : "navigation",
      "quit account" : "quit account",
      "register success" : "register success",
      "confirm password" : "confirm password",
      "double click" : "double click exit",
    },

    "zh" : {
      "net error" : "网络请求失败",
      "loading" : "加载中...",
      "collect success" : "收藏成功",
      "cancel collect success" : "取消收藏成功",
      "account" : "账号",
      "password" : "密码",
      "login" : "登录",
      "register" : "注册账号",
      "login success" : "登录成功",
      "collection" : "收藏",
      "article" : "文章",
      "project" : "项目",
      "navigation" : "导航",
      "quit account" : "退出当前账号",
      "register success" : "注册成功",
      "confirm password" : "确认密码",
      "double click" : "快速点击两次退出",
    }
  };

  get netError => _localizedValues[locale.languageCode]["net error"];
  get loading => _localizedValues[locale.languageCode]["loading"];
  get collectSuccess => _localizedValues[locale.languageCode]["collect success"];
  get cancelCollectSuccess => _localizedValues[locale.languageCode]["cancel collect success"];
  get account => _localizedValues[locale.languageCode]["account"];
  get password => _localizedValues[locale.languageCode]["password"];
  get login => _localizedValues[locale.languageCode]["login"];
  get register => _localizedValues[locale.languageCode]["register"];
  get loginSuccess => _localizedValues[locale.languageCode]["login success"];
  get collection => _localizedValues[locale.languageCode]["collection"];
  get article => _localizedValues[locale.languageCode]["article"];
  get project => _localizedValues[locale.languageCode]["project"];
  get navigation => _localizedValues[locale.languageCode]["navigation"];
  get quitAccount => _localizedValues[locale.languageCode]["quit account"];
  get registerSuccess => _localizedValues[locale.languageCode]["register success"];
  get confirmPassword => _localizedValues[locale.languageCode]["confirm password"];
  get doubleClick => _localizedValues[locale.languageCode]["double click"];

  static ProjectLocalizations of(BuildContext context){
    return Localizations.of(context, ProjectLocalizations);
  }
}