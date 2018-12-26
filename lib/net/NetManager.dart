import 'package:dio/dio.dart';
import 'package:wanandroid/bean/Result.dart';

class NetManager{
  static NetManager _instance;
  static Dio _dio;

  void init(){
    Options options = new Options(
      baseUrl: "http://www.wanandroid.com",
      connectTimeout: 5000,
      receiveTimeout: 3000
    );
    _dio = new Dio(options);
  }

  static NetManager getInstance(){
    if(_instance == null){
      _instance = new NetManager();
      _instance.init();
    }
    return _instance;
  }


   request(String url, String data, Options options) async{
    Response response;
    try {
      response = await _dio.request(url, data: data, options: options);
    }on DioError catch(e){
      if(e.response != null){
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      }else{
        print(e.message);
      }
      return Result(-2, "网络请求失败", "");
    }
    if(response != null){
      return Result.fromJson(response.data);
    }
  }
}