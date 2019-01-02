import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends Dialog{
  static bool _isShowing = false;

  LoadingDialog({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SpinKitFadingCircle(
        color: Colors.lightBlue,
        size: 50,
      ),
    );
  }

  void show(BuildContext context){
    if(!_isShowing) {
      _isShowing = true;
      showDialog(context: context
          , builder: (BuildContext context) {
            return this;
          });
    }
  }

  void dismiss(BuildContext context){
    if(_isShowing) {
      _isShowing = false;
      Navigator.pop(context);
    }
  }
}