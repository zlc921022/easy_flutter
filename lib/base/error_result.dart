import 'package:flutter_movie/base/base_result.dart';

class ErrorResult extends BaseResult {
  ErrorResult({Exception exception}) {
    this.exception = exception;
  }
}
