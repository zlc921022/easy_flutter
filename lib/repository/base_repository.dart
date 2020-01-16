import 'package:dio/dio.dart';
import 'package:flutter_movie/data/http_provider.dart';
import 'package:provider_mvvm/base/base_repository.dart';

import '../data/http_provider.dart';

class BaseMovieRepository extends BaseRepository {
  Dio dio = HttpProvider.instance.getDio();

  BaseMovieRepository() {
    setDio(dio);
  }
}
