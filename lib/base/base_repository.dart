import 'package:dio/dio.dart';
import 'package:flutter_movie/base/base_result.dart';
import 'package:flutter_movie/data/api_manager.dart';

class BaseRepository {
  Dio _dio;

  BaseRepository() {
    _dio = ApiManager.getDio();
  }

  Future<dynamic> get(String path, {Map<String, dynamic> params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params);
      if (response.statusCode != 200) {
        // 请求失败
        return BaseResult(
            code: response.statusCode, message: response.statusMessage);
      } else {
        // 请求成功
        return BaseResult(data: response.data, code: response.statusCode);
      }
    } catch (e) {
      print('异常信息：' + e.toString());
      return BaseResult(message: e.toString(), code: 500);
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    try {
      Response response = await _dio.post(path, data: params);
      if (response.statusCode != 200) {
        // 请求失败
        return BaseResult(
            code: response.statusCode, message: response.statusMessage);
      } else {
        // 请求成功
        return BaseResult(data: response.data, code: response.statusCode);
      }
    } catch (e) {
      print('异常信息：' + e.toString());
      return BaseResult(message: e.toString(), code: 500);
    }
  }
}
