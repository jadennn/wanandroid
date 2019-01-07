import 'package:flutter/material.dart';
import 'package:wanandroid/locale/ProjectLocalizations.dart';

//底部导航栏
class Navigations extends StatelessWidget {
  //定义回调函数
  final void Function(int page) onTap;

  final int page;

  const Navigations(this.page, this.onTap);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      color: Color.fromARGB(255, 240, 240, 240),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(0);
              }
            },
            child: Navigation(ProjectLocalizations.of(context).article, Icons.library_books,
                page == 0 ? Colors.redAccent : Colors.blueGrey),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(1);
              }
            },
            child: Navigation(
                ProjectLocalizations.of(context).project, Icons.archive, page == 1 ? Colors.redAccent : Colors.blueGrey),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(2);
              }
            },
            child: Navigation(
                ProjectLocalizations.of(context).navigation, Icons.bookmark, page == 2 ? Colors.redAccent : Colors.blueGrey),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(3);
              }
            },
            child: Navigation(ProjectLocalizations.of(context).collection, Icons.collections_bookmark,
                page == 3 ? Colors.redAccent : Colors.blueGrey),
          ),
        ),
      ],
    ),);
  }
}

//底部单个导航栏
class Navigation extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final Color _color;

  const Navigation(this._title, this._icon, this._color);

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 55),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
              child: Icon(
                _icon,
                color: _color,
              )),
          Text(
            _title,
            maxLines: 1,
            style: TextStyle(color: _color),
          ),
        ],
      ),
    );
  }
}
