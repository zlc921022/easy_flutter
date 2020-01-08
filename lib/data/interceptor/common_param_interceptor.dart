import 'package:dio/dio.dart';

class CommonParamInterceptor extends InterceptorsWrapper {

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
    // 添加通用元素
    for (String key in commonParams.keys) {
      newData[key] = commonParams[key];
    }
    // 参数回填
    for (String key in data.keys) {
      newData[key] = data[key];
    }
    return newData;
  }

  Map<String, dynamic> getCommonParams() {
    Map<String, dynamic> _commonParams = new Map();
    _commonParams['token'] = '11';
    _commonParams['id'] = '22';
    return _commonParams;
  }
}
