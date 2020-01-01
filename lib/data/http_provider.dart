import 'dart:io';

import 'package:dio/dio.dart';

class HttpProvider {
  static const String baseUrl = 'http://api.douban.com/v2/movie/';
  static const String apiKey = '0b2bdeda43b5688921839c8ecb20399b';
  static const String webUrl = 'https://movie.douban.com/';
  static final dio = _createDio();

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
  static Dio _createDio() {
    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        contentType: ContentType.json,
        queryParameters: {'apikey': apiKey});
    return Dio(options);
  }
}
