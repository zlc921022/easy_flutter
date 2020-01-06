import 'package:dio/dio.dart';
import 'package:flutter_movie/base/base_result.dart';
class BaseResponse extends Response<BaseResult> {
  BaseResult data;
  var errorCode;
  var errorMsg;
}
