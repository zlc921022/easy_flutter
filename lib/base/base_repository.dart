import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_movie/base/error_result.dart';
import 'package:flutter_movie/base/success_result.dart';
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
        return ErrorResult(exception: HttpException(response.statusMessage));
      } else {
        // 请求成功
        return SuccessResult(data: response.data);
      }
    } catch (e) {
      print('异常信息：' + e.toString());
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    try {
      Response response = await _dio.post(path, data: params);
      if (response.statusCode != 200) {
        // 请求失败
        return ErrorResult(exception: HttpException(response.statusMessage));
      } else {
        // 请求成功
        return SuccessResult(data: response.data);
      }
    } catch (e) {
      print('异常信息：' + e.toString());
    }
  }
}
