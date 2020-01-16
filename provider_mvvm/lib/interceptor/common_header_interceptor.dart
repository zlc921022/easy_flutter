import 'package:dio/dio.dart';

/// 添加通用请求头拦截器
class CommonHeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options.headers = getHeads();
    return super.onRequest(options);
  }

  /// 添加通用请求头参数 子类可以复写该方法
  Map getHeads() {
    Map<String, dynamic> map = new Map();
    map['token'] = '11';
    return map;
  }
}
