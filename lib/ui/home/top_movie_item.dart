import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/util/toast.dart';
import 'package:widget_chain/widget_chain.dart';

class TopMovieItem extends StatelessWidget {
  String imageUrl =
      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg';
  double width = (Screen.width - 4 * 12) / 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Toast.show('点击进入电影详情');
        AppNavigator.toMovieDetail(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonRoundedImage(imageUrl).intoExpanded(),
          SizedBox(height: 2),
          Text('美丽人生',
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
              StaticRatingBar(
                size: 13,
                rate: 3.1,
              ),
              SizedBox(width: 5),
              Text('8.8',
                  style: TextStyle(fontSize: 10, color: AppColor.black_99)),
            ],
          )
        ],
      ),
    );
  }
}
