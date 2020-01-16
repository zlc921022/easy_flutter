import 'package:dio/dio.dart';
import 'package:provider_mvvm/interceptor/common_dynamic_url_interceptor.dart';
import 'package:provider_mvvm/interceptor/common_header_interceptor.dart';
import 'package:provider_mvvm/interceptor/common_log_interceptor.dart';
import 'package:provider_mvvm/interceptor/common_param_interceptor.dart';

class HttpProvider {
  static const String BASE_URL = 'http://api.douban.com/v2/movie/';
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
        baseUrl: BASE_URL,
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000);
    final dio = new Dio(options);
    // 添加通用拦截器
    for (Interceptor interceptor in getInterceptors()) {
      dio.interceptors.add(interceptor);
    }
    return dio;
  }

  // 子类可以复写该方法 自定义添加拦截器
  List<Interceptor> getInterceptors() {
    List<Interceptor> interceptors = [];
    interceptors.add(CommonDynamicUrlInterceptor());
    interceptors.add(CommonHeaderInterceptor());
    interceptors.add(CommonParamInterceptor());
    interceptors.add(CommonLogInterceptor());
    return interceptors;
  }

  Dio getDio() {
    if (_dio == null) {
      _dio = _createDio();
    }
    return _dio;
  }
}
