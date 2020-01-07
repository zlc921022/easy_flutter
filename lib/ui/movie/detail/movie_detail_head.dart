import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../../util/screen.dart';

class MovieDetailHead extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieDetailHead(this.movieDetail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image(
              image: CachedNetworkImageProvider(movieDetail.images?.large),
              fit: BoxFit.cover,
              width: Screen.width,
              height: 218,
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                color: AppColor.black_33,
                width: Screen.width,
                height: 218,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                AppNavigator.back(context);
              },
              child: Image.asset('images/icon_arrow_back_white.png'),
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                CommonRoundedImage(movieDetail.images?.small,
                    width: 100, height: 134),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(movieDetail.title,
                        style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                            '${movieDetail.originalTitle} (${movieDetail.year})',
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        StaticRatingBar(
                            size: 13, rate: movieDetail.rating.average / 2),
                        SizedBox(width: 5),
                        Text(movieDetail.rating.average.toString(),
                            style: TextStyle(color: AppColor.white, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${countries2String(movieDetail.countries)}/${list2String(movieDetail.genres)}/上映时间：'
                          '${list2String(movieDetail.pubdates)}/ 片长: ${list2String(movieDetail.durations)}/'
                          '${list2String(movieDetail.directors)}/${actor2String(movieDetail.casts)}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColor.white, fontSize: 12)),
                  ],
                ).intoExpanded()
              ],
            )
          ],
        ).intoContainer(margin: const EdgeInsets.all(15)),
      ],
    );
  }

  String actor2String(List<MovieActor> actors) {
    StringBuffer sb = new StringBuffer();
    actors.forEach((actor) {
      sb.write(' ${actor.name} ');
    });
    return sb.toString();
  }

  String list2String(List list) {
    StringBuffer sb = new StringBuffer();
    list.forEach((item) {
      sb.write(' $item ');
    });
    return sb.toString();
  }

  String countries2String(List countries) {
    StringBuffer sb = new StringBuffer();
    countries.forEach((country) {
      sb.write('$country ');
    });
    return sb.toString();
  }
}
