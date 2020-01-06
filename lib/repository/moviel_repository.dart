
import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/data/api/app_api.dart';

class MovieRepository extends BaseRepository{

  // 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    var result  = await get(AppApi.getWeeklyList());
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  // 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    var result = await get(AppApi.getNewMovies());
    return result.data['subjects'];
  }

  // 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    var result = await get(AppApi.getUsBox());
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  // 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    var result = await get(AppApi.getTop250(),params : {'start': start, 'count': count});
    return result.data['subjects'];
  }

  // 获取电影详情
  Future<dynamic> getMovieDetail(String movieId) async {
    var result = await get(AppApi.getMovieDetail());
    return result.data;
  }

}