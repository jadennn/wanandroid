import 'package:flutter/material.dart';

//底部导航栏
class Navigations extends StatelessWidget{
  //定义回调函数
  final void Function(int page) onTap;

  final int page;
  const Navigations(this.page, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(child: GestureDetector(
          onTap: (){
            if(onTap != null) {
              onTap(0);
            }
          },
          child:Navigation("文章", Icons.library_books, page==0?Colors.red:Colors.grey),),
        ),
        Expanded(child: GestureDetector(
          onTap: (){
            if(onTap != null) {
              onTap(1);
            }
          },
          child:Navigation("项目", Icons.archive, page==1?Colors.red:Colors.grey),),
        ),
        Expanded(child: GestureDetector(
          onTap: (){
            if(onTap != null) {
              onTap(2);
            }
          },
          child:Navigation("导航", Icons.bookmark, page==2?Colors.red:Colors.grey),),
        ),
        Expanded(child: GestureDetector(
          onTap: (){
            if(onTap != null) {
              onTap(3);
            }
          },
          child:Navigation("收藏", Icons.collections_bookmark, page==3?Colors.red:Colors.grey),),
        ),
      ],
    );
  }
}

//底部单个导航栏
class Navigation extends StatelessWidget{
  final String _title;
  final IconData _icon;
  final Color _color;
  const Navigation(this._title, this._icon, this._color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50),
      child:  Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
              child:Icon(_icon,
                color: _color,)),
          Text(_title, maxLines: 1,
            style: TextStyle(
                color: _color
            ),),
        ],
      ),);
  }
}