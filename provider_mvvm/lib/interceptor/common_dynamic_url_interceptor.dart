import 'package:dio/dio.dart';

/// 添加通用动态修改baseUrl的拦截器
class CommonDynamicUrlInterceptor extends InterceptorsWrapper {
  static const String BASE_URL = 'http://api.douban.com/v2/movie/';

  @override
  Future onRequest(RequestOptions options) {
    options.baseUrl = getBaseUrl();
    return super.onRequest(options);
  }

  String getBaseUrl() {
    return BASE_URL;
  }
}
