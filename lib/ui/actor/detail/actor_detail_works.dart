import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor_work.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 演员详情 -- 影视作品
class ActorDetailWorks extends StatelessWidget {
  final List<MovieActorWork> works;

  ActorDetailWorks(this.works);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('影视作品'),
        SizedBox.fromSize(
          size: Size.fromHeight(180),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: works?.length,
              itemBuilder: (context, index) {
                var work = works[index];
                return _buildWorksItem(context, work, index);
              }),
        )
      ],
    );
  }

  /// 影视作品子条目
  Widget _buildWorksItem(BuildContext context, MovieActorWork work, int index) {
    double width = 100;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movieItem: work.movie);
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 15, right: (index == works.length - 1) ? 15 : 0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonRoundedImage(work.movie?.images?.small,
                width: width, height: 100 / 0.75),
            SizedBox(height: 5),
            Container(
              width: width,
              child: Text(work.movie?.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: AppColor.white)),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                CommonRatingBar(
                    size: 13,
                    rate: (work?.movie?.rating?.average != null)
                        ? work.movie.rating.average / 2
                        : 0),
                SizedBox(width: 5),
                Text(work?.movie?.rating?.average?.toString(),
                    style: TextStyle(fontSize: 12, color: AppColor.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
