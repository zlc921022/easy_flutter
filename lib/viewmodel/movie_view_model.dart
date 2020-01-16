import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movie/model/movie_top_bannner.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/util/movie_data_util.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider_mvvm/base/base_view_model.dart';

/// 电影ViewModel
class MovieViewModel extends BaseViewModel<MovieRepository> {
  var weeklyList;
  var top250List;
  var usBoxList;
  var newMoviesList;
  List<MovieTopBanner> banners;

  /// 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    var result = await mRepository.getWeeklyList();
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  /// 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    var result = await mRepository.getNewMoviesList();
    return result?.data['subjects'];
  }

  /// 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    var result = await mRepository.getUsBoxList();
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  /// 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    var result = await mRepository.getTop250List(start: start, count: count);
    return result?.data['subjects'];
  }

  void loadData({int start, int count}) async {
    await requestData(_loadData(start, count));
  }

  Future<dynamic> _loadData(int start, int count) async {
    setLoading();

    weeklyList = MovieDataUtil.getMovieList(await getWeeklyList());
    top250List = MovieDataUtil.getMovieList(
        await getTop250List(start: start, count: count));
    usBoxList = MovieDataUtil.getMovieList(await getUsBoxList());
    newMoviesList = MovieDataUtil.getMovieList(await getNewMoviesList());

    var paletteGenerator1 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(weeklyList[0].images.small));
    var paletteGenerator2 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(top250List[0].images.small));
    var paletteGenerator3 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(usBoxList[0].images.small));
    var paletteGenerator4 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(newMoviesList[0].images.small));

    if (isEmpty()) {
      setEmpty();
      return null;
    }
    banners = [
      new MovieTopBanner(weeklyList, '一周口碑电影榜', '每周五更新·共10部', 'weekly',
          paletteGenerator1.darkVibrantColor),
      new MovieTopBanner(top250List, '豆瓣电影Top250', '豆瓣榜单·共250部', 'top250',
          paletteGenerator2.darkVibrantColor),
      new MovieTopBanner(newMoviesList, '一周新电影榜', '每周五更新·共10部', 'new_movies',
          paletteGenerator3.darkVibrantColor),
      new MovieTopBanner(usBoxList, '北美电影票房榜', '每周五更新·共10部', 'usBox',
          paletteGenerator4.darkVibrantColor),
    ];
    setSuccess();
  }

  bool isEmpty() {
    if (weeklyList == null &&
            top250List == null &&
            usBoxList == null &&
            newMoviesList == null ||
        (weeklyList.isEmpty &&
            top250List.isEmpty &&
            usBoxList.isEmpty &&
            newMoviesList.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  /// 获取电影详情
  Future<dynamic> getMovieDetail(String movieId) async {
    var result = await requestData(mRepository.getMovieDetail(movieId));
    return result?.data;
  }

  @override
  MovieRepository createRepository() {
    return new MovieRepository();
  }
}
