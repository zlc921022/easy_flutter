
import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/moviel_repository.dart';

class MovieViewModel extends BaseViewModel<MovieRepository>{

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  // 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    return await mRepository.getWeeklyList();
  }

  // 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    return await mRepository.getNewMoviesList();
  }

  // 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    return await mRepository.getUsBoxList();
  }

  // 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    return await mRepository.getTop250List(start :start,count:count);
  }

  // 获取电影详情
  Future<dynamic> getMovieDetail(String movieId) async {
    return await mRepository.getMovieDetail(movieId);
  }

}