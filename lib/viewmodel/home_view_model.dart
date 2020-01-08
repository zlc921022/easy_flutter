import 'package:flutter_movie/base/base_view_model.dart';
import 'package:flutter_movie/model/movie_banner.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/repository/home_respository.dart';
import 'package:flutter_movie/util/movie_data_util.dart';

class HomeViewModel extends BaseViewModel<HomeRepository> {

  List<NewsBanner> newsBannerData;
  List<MovieItem> comingData;
  List<MovieItem> nowPlayData;

  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getComingList(start: start, count: count));
    return result?.data['subjects'];
  }

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    var result = await requestData(
        mRepository.getNowPlayingList(start: start, count: count));
    return result?.data['subjects'];
  }

  ///  获取首页热门新闻文章
  Future<dynamic> getNewsList() async {
    return await mRepository.getNewsList();
  }

  Future<dynamic> loadData({int start, int count}) async {
    await requestData(_loadData(start: start, count: count));
  }

  Future<dynamic> _loadData({int start, int count}) async {
    var newsList = await getNewsList();
    var nowPlaylist = await getNowPlayingList(start: start, count: count);
    var comingList = await getComingList(start: start, count: count);
    this.newsBannerData = _news2Banner(newsList);
    this.comingData = MovieDataUtil.getMovieList(comingList);
    this.nowPlayData = MovieDataUtil.getMovieList(nowPlaylist);
    return comingList;
  }

  List<NewsBanner> _news2Banner(var list) {
    List content = list;
    List<NewsBanner> banners = [];
    content.forEach((data) {
      banners.add(NewsBanner(data));
    });
    return banners;
  }

  @override
  HomeRepository createRepository() {
    return new HomeRepository();
  }
}
