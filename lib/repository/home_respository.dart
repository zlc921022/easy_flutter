import 'package:flutter_movie/base/base_repository.dart';
import 'package:flutter_movie/data/api/app_api.dart';
import 'package:flutter_movie/data/http_provider.dart';
import 'package:flutter_movie/model/movie_news.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class HomeRepository extends BaseRepository {

  ///  获取首页热门新闻文章
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

  /// 获取正在上映的电影
  Future<dynamic> getNowPlayingList({int start, int count}) async {
    var result = await get(AppApi.getNowPlayingList(), params: {'start':start,'count' : count});
    return result.data['subjects'];
  }

  /// 获取即将上映电影
  Future<dynamic> getComingList({int start, int count}) async {
    var result = await get(AppApi.getComingSoon(), params: {'start':start,'count' : count});
    return result.data['subjects'];
  }

  /// 获取本周口碑榜电影
  Future<dynamic> getWeeklyList() async {
    var result = await get(AppApi.getWeeklyList());
    List content = result.data['subjects'];
    List movies = [];
    content.forEach((data) {
      movies.add(data['subject']);
    });
    return movies;
  }
}
