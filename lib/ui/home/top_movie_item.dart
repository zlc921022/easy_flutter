import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 影院热映条目
class TopMovieItem extends StatelessWidget {
  final MovieItem movieItem;

  TopMovieItem(this.movieItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movieItem: movieItem);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: CommonRoundedImage(movieItem.images.small)),
          SizedBox(height: 2),
          Text(movieItem.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 14)),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CommonRatingBar(
                size: 13,
                rate: movieItem.rating.average / 2,
              ),
              SizedBox(width: 5),
              Text(movieItem.rating?.average?.toString(),
                  style: TextStyle(fontSize: 10, color: AppColor.black_99)),
            ],
          )
        ],
      ),
    );
  }
}
