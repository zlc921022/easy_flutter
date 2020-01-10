import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/repository/movie_repository.dart';

/// 电影列表ViewModel
class MovieListViewModel extends BaseViewModel<MovieRepository> {
  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getComingList(start: start, count: count));
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getNowPlayingList(start: start, count: count));
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  /// 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    var result = await requestData(mRepository.getWeeklyList());
    if (result == null || result.data == null) {
      return null;
    }
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  /// 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    var result = await requestData(mRepository.getNewMoviesList());
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  /// 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    var result = await requestData(mRepository.getUsBoxList());
    if (result == null || result.data == null) {
      return null;
    }
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  /// 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    var result = await requestData(
        mRepository.getTop250List(start: start, count: count));
    if (result != null && result.data != null) {
      return result.data['subjects'];
    } else {
      return null;
    }
  }

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }
}
