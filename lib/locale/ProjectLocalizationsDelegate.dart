
import 'package:flutter/foundation.dart';
import 'package:wanandroid/locale/ProjectLocalizations.dart';
import 'package:flutter/cupertino.dart';

class ProjectLocalizationsDelegate extends LocalizationsDelegate<ProjectLocalizations>{
  const ProjectLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  Future<ProjectLocalizations> load(Locale locale) {
    return SynchronousFuture(ProjectLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<ProjectLocalizations> old) {
    return false;
  }

  static ProjectLocalizationsDelegate delegate = const ProjectLocalizationsDelegate();

}