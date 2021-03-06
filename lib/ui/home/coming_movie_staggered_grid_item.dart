import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';

///即将上映条目
class ComingMovieStaggeredGridItem extends StatelessWidget {
  final MovieItem movieItem;

  ComingMovieStaggeredGridItem(this.movieItem);

  @override
  Widget build(BuildContext context) {
    double width = (ScreenUtil.width - 48) / 2;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movieItem: movieItem);
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: CommonRoundedImage(movieItem.images.small,width: width)),
              SizedBox(height: 2),
              Text(movieItem.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                      fontSize: 14)),
              SizedBox(height: 2),
              Text('${movieItem.collectCount}人想看',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: AppColor.black_99)),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1, color: AppColor.red),
                ),
                child: Text(
                    '${movieItem.mainlandPubdate.split('-')[1]}月${movieItem.mainlandPubdate.split('-')[2]}日',
                    style: TextStyle(fontSize: 9, color: AppColor.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
