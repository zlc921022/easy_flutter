
import 'package:provider_mvvm/base/base_repository.dart';
import 'package:provider_mvvm/data/api/api_service.dart';

/// 电影
class MovieRepository extends BaseRepository {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await get(ApiService.getComingSoon(),
        params: {'start': start, 'count': count});
    return result;
  }
}
