import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';

class MovieListItemView extends StatelessWidget {
  final String action;
  final MovieItem movieItem;

  MovieListItemView(this.movieItem, this.action);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context,movieItem: movieItem);
      },
      child: Container(
        color: AppColor.white,
        margin: const EdgeInsets.only(left: 15, top: 15, right: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonRoundedImage(
                  this.movieItem.images.small,
                  width: 100,
                  height: 100 / 0.75,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(movieItem.title,
                        style: TextStyle(
                            color: AppColor.black_33,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        CommonRatingBar(
                            size: 13, rate: movieItem.rating.average / 2),
                        SizedBox(width: 5),
                        Text(movieItem.rating.average.toString(),
                            style: TextStyle(
                                color: AppColor.black_99, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        '${movieItem.year} /${list2String(movieItem.genres)} / '
                        '${actor2String(movieItem.directors)}/${actor2String(movieItem.casts)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: AppColor.black_99, fontSize: 14)),
                  ],
                )),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 100 / 0.75,
                  child: _buildRight(),
                )
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: AppColor.black_cc,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRight() {
    if (this.action == 'top_movie') {
      // 即将上映
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.yellow,
          ),
          SizedBox(height: 20),
          Text(
            '收藏',
            style: TextStyle(fontSize: 14, color: Colors.yellow),
          )
        ],
      );
    } else {
      //影院热映
      return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColor.red, width: 1)),
        child: Text(
          '${movieItem?.mainlandPubdate?.split('-')[1]}月\n${movieItem?.mainlandPubdate?.split('-')[2]}日',
          style: TextStyle(fontSize: 14, color: AppColor.red),
        ),
      );
    }
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
}
