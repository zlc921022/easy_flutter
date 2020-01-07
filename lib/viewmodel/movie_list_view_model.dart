import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/util/movie_data_util.dart';

class MovieListViewModel extends BaseViewModel<MovieRepository> {
  List<MovieItem> movieData;

  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getComingList(start: start, count: count));
    var comingList = result?.data['subjects'];
    this.movieData = MovieDataUtil.getMovieList(comingList);
    return comingList;
  }

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getNowPlayingList(start: start, count: count));
    var nowPlayingList = result?.data['subjects'];
    this.movieData = MovieDataUtil.getMovieList(nowPlayingList);
    return nowPlayingList;
  }

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }
}
