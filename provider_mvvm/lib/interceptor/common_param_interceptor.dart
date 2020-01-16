import 'package:dio/dio.dart';

/// 通用参数拦截器
class CommonParamInterceptor extends InterceptorsWrapper {
  static const String apiKey = '0b2bdeda43b5688921839c8ecb20399b';

  CommonParamInterceptor();

  @override
  Future onRequest(RequestOptions options) {
    var method = options.method;
    if (method == 'GET') {
      options.queryParameters = _getAddParams(options);
    } else {
      options.data = _postAddParams(options);
    }
    return super.onRequest(options);
  }

  Map<String, dynamic> _getAddParams(RequestOptions options) {
    var params = options.queryParameters;
    var commonParams = getCommonParams();
    for (String key in params.keys) {
      commonParams[key] = params[key];
    }
    return commonParams;
  }

  Map<String, dynamic> _postAddParams(RequestOptions options) {
    var newData = new RequestOptions().data;
    var data = options.data;
    var commonParams = getCommonParams();

    /// 添加通用元素
    for (String key in commonParams.keys) {
      newData[key] = commonParams[key];
    }

    /// 参数回填
    for (String key in data.keys) {
      newData[key] = data[key];
    }
    return newData;
  }

  /// 添加并获取通用参数 子类可以复写
  Map<String, dynamic> getCommonParams() {
    Map<String, dynamic> commonParams = new Map();
    commonParams['apikey'] = apiKey;
    return commonParams;
  }
}
