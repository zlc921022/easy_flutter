import 'package:dio/dio.dart';
import 'package:example/api_service.dart';
import 'package:example/http_provider.dart';
import 'package:provider_mvvm/base/base_repository.dart';

/// 电影
class MovieRepository extends BaseRepository {
  Dio dio = HttpProvider.instance.getDio();

  MovieRepository() {
    setDio(dio);
  }

  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await get(ApiService.getComingSoon(),
        params: {'start': start, 'count': count});
    return result;
  }
}
