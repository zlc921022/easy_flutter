import 'package:dio/dio.dart';

class CommonParamInterceptor extends InterceptorsWrapper {
  Map<String, dynamic> _commonParams = new Map();

  CommonParamInterceptor() {
    _commonParams['token'] = '11';
    _commonParams['id'] = '22';
  }

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
    for (String key in params.keys) {
      if (!_commonParams.containsKey(key)) {
        _commonParams[key] = params[key];
      }
    }
    return _commonParams;
  }

  Map<String, dynamic> _postAddParams(RequestOptions options) {
    var newData = new RequestOptions().data;
    var data = options.data;
    // 添加通用元素
    for (String key in _commonParams.keys) {
      newData[key] = _commonParams[key];
    }
    // 参数回填
    for (String key in data.keys) {
      if (!newData.containsKey(key)) {
        newData[key] = data[key];
      }
    }
    return newData;
  }
}
