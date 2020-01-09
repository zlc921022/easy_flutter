import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/model/movie_top_bannner.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:flutter_movie/ui/movie/movie_top_list_view.dart';
import 'package:flutter_movie/util/screen.dart';

/// 首页电影榜单条目
class TopListItemView extends StatelessWidget {
  final MovieTopBanner topBanner;

  TopListItemView(this.topBanner);

  @override
  Widget build(BuildContext context) {
    double height = 100;
    return GestureDetector(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return new MovieTopListView(topBanner.title, topBanner.subTitle,
                topBanner.movies[0]?.images?.medium, topBanner.action);
          }));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: getBorderRadius(4, 0),
                    child: Image(
                      image: CachedNetworkImageProvider(
                          topBanner.movies[0]?.images?.medium),
                      fit: BoxFit.cover,
                      width: Screen.width,
                      height: height,
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: Screen.width,
                      height: height,
                      decoration: BoxDecoration(
                          borderRadius: getBorderRadius(4, 0),
                          color: AppColor.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(topBanner.subTitle,
                            style:
                                TextStyle(fontSize: 14, color: AppColor.white)),
                        SizedBox(height: 15),
                        Text(topBanner.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColor.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListView.builder(
                    itemCount: topBanner.movies.length,
                    itemBuilder: (context, index) {
                      var movie = topBanner.movies[index];
                      return _buildMovieItem(movie, index);
                    },
                  ),
                  decoration: new BoxDecoration(
                    color: topBanner.coverColor.color,
                    borderRadius: getBorderRadius(0, 4),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  /// 电影条目
  Widget _buildMovieItem(MovieItem movieItem, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text('${index + 1}. ${movieItem.title}',
                  style: TextStyle(fontSize: 12, color: AppColor.white))),
          CommonRatingBar(size: 13, rate: movieItem.rating.average / 2),
          SizedBox(width: 5),
          Text(movieItem.rating.average.toString(),
              style: TextStyle(fontSize: 11, color: AppColor.white)),
        ],
      ),
    );
  }

  /// 获取图片圆角半径
  BorderRadius getBorderRadius(double top, double bottom) {
    return BorderRadius.only(
        topLeft: Radius.circular(top),
        topRight: Radius.circular(top),
        bottomLeft: Radius.circular(bottom),
        bottomRight: Radius.circular(bottom));
  }
}
