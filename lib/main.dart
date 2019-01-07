import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wanandroid/locale/ProjectLocalizationsDelegate.dart';
import 'package:wanandroid/page/LoginPage.dart';

void main() {
  runApp(Page());
}

class Page extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ProjectLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale("zh", "CH"),
        const Locale("en", "US"),
      ],
      title: "wanandroid",
      home: LoginPage(),
    );
  }

}

