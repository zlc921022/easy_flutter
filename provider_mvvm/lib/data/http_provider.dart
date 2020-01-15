import 'package:dio/dio.dart';

import 'interceptor/common_header_interceptor.dart';
import 'interceptor/common_log_interceptor.dart';
import 'interceptor/common_param_interceptor.dart';

class HttpProvider {
  static const String baseUrl = 'http://api.douban.com/v2/movie/';
  static const String apiKey = '0b2bdeda43b5688921839c8ecb20399b';
  static const String webUrl = 'https://movie.douban.com/';

  Dio _dio;

  factory HttpProvider() => _getProvider();

  HttpProvider._internal();

  static HttpProvider get instance => _getProvider();
  static HttpProvider _httpProvider;

  static HttpProvider _getProvider() {
    if (_httpProvider == null) {
      _httpProvider = new HttpProvider._internal();
    }
    return _httpProvider;
  }

  ///创建dio网络请求对象
  Dio _createDio() {
    final options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000,
        queryParameters: {"apikey": apiKey});
    final dio = new Dio(options);
    // 添加通用拦截器
    dio.interceptors.add(CommonHeaderInterceptor());
    dio.interceptors.add(CommonParamInterceptor());
    dio.interceptors.add(CommonLogInterceptor());
    return dio;
  }

  Dio getDio() {
    if (_dio == null) {
      _dio = _createDio();
    }
    return _dio;
  }
}
