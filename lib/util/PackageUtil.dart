import 'package:package_info/package_info.dart';

class PackageUtil{
  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;


  static void init() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

}