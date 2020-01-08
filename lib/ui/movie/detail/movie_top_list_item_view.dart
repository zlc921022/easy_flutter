import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';

class MovieTopListItemView extends StatelessWidget {
  final MovieItem movieItem;
  final int index;
  MovieTopListItemView(this.movieItem,this.index);

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    switch (index) {
      case 1:
        rankColor = Color(0xffFF6678);
        break;
      case 2:
        rankColor = Color(0xffF98B56);
        break;
      case 3:
        rankColor = Color(0xffFFC05F);
        break;
      default:
        rankColor = Color(0xffD1CEC9);
        break;
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.toMovieDetail(context,movieItem: movieItem);
      },
      child: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 15, top: 15, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: rankColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text('No.$index',
                  style: TextStyle(color: AppColor.white, fontSize: 14)),
            ),
            SizedBox(height: 15),
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
                        StaticRatingBar(
                          size: 13,
                          rate: movieItem.rating.average / 2,
                        ),
                        SizedBox(width: 5),
                        Text(movieItem.rating.average.toString(),
                            style: TextStyle(
                                color: AppColor.black_99, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        '${movieItem.year} / ${list2String(movieItem.genres)} / '
                        '${actor2String(movieItem.directors)} /${actor2String(movieItem.casts)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: AppColor.black_99, fontSize: 14)),
                  ],
                )),
                _buildRight(),
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
    return Container(
      width: 40,
      height: 100 / 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.yellow,
          ),
          SizedBox(height: 12),
          Text(
            '收藏',
            style: TextStyle(fontSize: 14, color: Colors.yellow),
          )
        ],
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
