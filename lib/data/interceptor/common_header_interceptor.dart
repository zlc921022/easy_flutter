import 'package:dio/dio.dart';

/// 添加通用请求头拦截器
class CommonHeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options.headers = _getHeads();
    return super.onRequest(options);
  }

  /// 添加通用请求头参数
  Map _getHeads() {
    Map<String, dynamic> map = new Map();
    map['token'] = '11';
    map['id'] = '22';
    map['name'] = '33';
    return map;
  }
}
