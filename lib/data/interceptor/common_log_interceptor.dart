import 'package:dio/dio.dart';

class CommonLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print('HTTP请求开始: -->${options?.method} ${options?.baseUrl}${options.path}');
    if (options.headers != null) {
      print('request heads: ${options.headers.toString()}');
    }
    if (options.method == 'GET') {
      print('request params: ${options.queryParameters.toString()}');
    } else {
      print('request params: ${options.data.toString()}');
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (response.data != null) {
      print('response : ${response.data.toString()}');
    }
    print('HTTP请求结束: -->${response?.request?.method} ${response?.request?.baseUrl}${response?.request?.path}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print(
        'onError errorCode: ${err?.response?.statusCode}, errorMessage: ${err?.message}');
    return super.onError(err);
  }
}
