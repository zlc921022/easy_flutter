import 'package:dio/dio.dart';
import 'package:flutter_movie/data/http_provider.dart';
import 'package:flutter_movie/model/movie_news.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'api/app_api.dart';

class ApiManager {

  static Dio _dio;
  ApiManager._internal();

  static ApiManager _apiManager;
  static ApiManager instance = _geApiManager();
  factory ApiManager() => _geApiManager();

  static ApiManager _geApiManager(){
    if(_apiManager == null){
      _apiManager =  new ApiManager._internal();
    }
    return _apiManager;
  }

  static Dio getDio(){
    return HttpProvider.instance.getDio();
  }

  /**
   *  获取首页热门新闻文章
   */
  Future<List<MovieNews>> getNewsList() async {
    List<MovieNews> news = [];
    await http.get(HttpProvider.webUrl).then((http.Response response) {
      var document = parse(response.body.toString());
      List<dom.Element> items =
          document.getElementsByClassName('gallery-frame');
      items.forEach((item) {
        String cover =
            item.getElementsByTagName('img')[0].attributes['src'].toString();
        String link =
            item.getElementsByTagName('a')[0].attributes['href'].toString();
        String title =
            item.getElementsByTagName('h3')[0].text.toString().trim();
        String summary =
            item.getElementsByTagName('p')[0].text.toString().trim();
        MovieNews movieNews = new MovieNews(title, cover, summary, link);
        news.add(movieNews);
      });
    });
    return news;
  }

  // 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    Response response = await _dio.get(AppApi.getNowPlayingList(),
        queryParameters: {"start": start, 'count': count});
    return response.data['subjects'];
  }

  // 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.getComingSoon(),
        queryParameters: {"start": start, 'count': count});
    return response.data['subjects'];
  }

  // 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    Response<Map> response = await _dio.get(AppApi.getWeeklyList());
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  // 获取新片榜电影
  Future<dynamic> getNewMoviesList() async {
    Response<Map> response = await _dio.get(AppApi.getNewMovies());
    return response.data['subjects'];
  }

  // 获取北美票房榜电影
  Future<dynamic> getUsBoxList() async {
    Response<Map> response = await _dio.get(AppApi.getUsBox());
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }

  // 获取 top250 榜单
  Future<dynamic> getTop250List({int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.getTop250(),
        queryParameters: {'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 根据标签搜索
  Future<dynamic> getSearchListByTag({String tag, int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.searchByTag(),
        queryParameters: {'tag': tag, 'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 根据关键字搜索
  Future<dynamic> getSearchListByKey({String key, int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.searchByKey(),
        queryParameters: {'q': key, 'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 获取电影详情
  Future<dynamic> getMovieDetail(String movieId) async {
    Response<Map> response = await _dio.get(AppApi.getMovieDetail());
    return response.data;
  }

  // 影片剧照
  Future<dynamic> getMovieAlbum({String movieId, int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.getMovieStagePhoto(movieId),
        queryParameters: {'start': start, 'count': count});
    return response.data['photos'];
  }

  // 演员详细信息
  Future<dynamic> getActorDetail(String actorId) async {
    Response<Map> response = await _dio.get(AppApi.getActorDetail(actorId));
    return response.data;
  }

  // 获取演员相册
  Future<dynamic> getActorPhotos({String actorId, int start, int count}) async {
    Response<Map> response = await _dio.get(AppApi.getActorPhotos(actorId),
        queryParameters: {'start': start, 'count': count});
    return response.data['photos'];
  }
}
