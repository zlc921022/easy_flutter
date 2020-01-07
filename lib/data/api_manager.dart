import 'package:dio/dio.dart';
import 'package:flutter_movie/data/http_provider.dart';

class ApiManager {

  ApiManager._internal();

  static ApiManager _apiManager;
  static ApiManager instance = _geApiManager();

  factory ApiManager() => _geApiManager();

  static ApiManager _geApiManager() {
    if (_apiManager == null) {
      _apiManager = new ApiManager._internal();
    }
    return _apiManager;
  }

  static Dio getDio() {
    return HttpProvider.instance.getDio();
  }
}
