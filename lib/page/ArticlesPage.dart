import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bean/Article.dart';
import 'package:wanandroid/bean/Articles.dart';
import 'package:wanandroid/bean/Result.dart';
import 'package:wanandroid/net/NetManager.dart';
import 'package:wanandroid/util/ToastUtil.dart';

class ArticlesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ArticlesPageState();
  }

}

class ArticlesPageState extends State<ArticlesPage>{
  final _articles = <Article>[];
  int _page = 0;

  final _titleFont = const TextStyle(
      fontSize: 18.0,
      color: Colors.black);
  final _descFont = const TextStyle(
    fontSize: 12.0,
    color: Colors.grey
  );

  @override
  void initState() {
    _getArticles(page: _page++);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildArticles(),
    );
  }

  Widget buildArticles(){
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: _articles.length * 2,
        itemBuilder: (BuildContext context, int i){
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          if(index >= _articles.length - 1){
            _getArticles(page: _page++);
          }
          return _buildRow(_articles[index], index);
        });
  }


   void _getArticles({int page=0}) async {
    Result  result = await NetManager.getInstance().request("/article/list/$page/json", null, Options(
        method: "GET"));
    if(result.errorCode == 0){
      setState(() {
        Articles articles = Articles.fromJson(result.data);
        print(articles.toString());
        _articles.addAll(articles.datas);
      });
    }else{
      ToastUtil.showError(result.errorMsg);
     }
  }

  Widget _buildRow(Article article, int index) {
    return ListTile(
      title: Text(
        article.title,
        maxLines: 1,
        style: _titleFont,),
      subtitle: Text(
        article.desc,
        maxLines: 1,
        style: _descFont,
      ),
      trailing: new Icon(
        article.collect ? Icons.favorite : Icons.favorite_border,
        color: article.collect ? Colors.red : null,
      ),
      onTap: (){
        _collect(article, index);
      },
    );
  }

  void _collect(Article article, int index) async{
    if(article.collect){
      Result result = await NetManager.getInstance().request(
          "/lg/uncollect_originId/${article.id}/json", null, Options(
          method: "POST"));
      if(result.errorCode == 0){
        ToastUtil.showTips("取消收藏成功");
        article.collect = !article.collect;
        _articles.removeAt(index);
        _articles.insert(index, article);
        setState(() {
        });
      }else{
        ToastUtil.showError(result.errorMsg);
      }
    }else {
      Result result = await NetManager.getInstance().request(
          "/lg/collect/${article.id}/json", null, Options(
          method: "POST"));
      if(result.errorCode == 0){
        ToastUtil.showTips("收藏成功");
        article.collect = !article.collect;
        _articles.removeAt(index);
        _articles.insert(index, article);
        setState(() {
        });
      }else{
        ToastUtil.showError(result.errorMsg);
      }
      setState(() {
      });
    }
  }
}