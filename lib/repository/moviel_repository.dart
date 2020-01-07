import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/data/api/app_api.dart';

class MovieRepository extends BaseRepository {
  // 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    return await get(ApiService.getWeeklyList());
  }

  // 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    return await get(ApiService.getNewMovies());
  }

  // 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    return await get(ApiService.getUsBox());
  }

  // 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    var result = await get(ApiService.getTop250(),
        params: {'start': start, 'count': count});
    return result;
  }

  // 获取电影详情
  Future<dynamic> getMovieDetail(String movieId) async {
    return await get(ApiService.getMovieDetail());
  }
}
