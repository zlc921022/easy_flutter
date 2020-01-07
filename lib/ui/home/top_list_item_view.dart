import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/model/movie_top_bannner.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:flutter_movie/ui/movie/detail/movie_top_list_view.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:widget_chain/widget_chain.dart';

class TopListItemView extends StatelessWidget {
  final MovieTopBanner topBanner;

  TopListItemView(this.topBanner);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return new MovieTopListView();
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image(
                  image: CachedNetworkImageProvider(
                      topBanner.movies[0]?.images?.medium),
                  fit: BoxFit.cover,
                  width: Screen.width,
                  height: 100,
                ).intoClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: Screen.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4))
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
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
                ).intoContainer(margin: const EdgeInsets.only(left: 20))
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
                    return _buildListItem(movie, index);
                  },
                ),
                decoration: new BoxDecoration(
                  color: topBanner.coverColor.color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3)),
                ),
              ),
            )
          ],
        ).intoContainer(margin: EdgeInsets.symmetric(horizontal: 5)));
  }

  Widget _buildListItem(
      MovieItem movieItem,int index) {
    return Row(
      children: <Widget>[
        Text('${index + 1}. ${movieItem.title}',
                style: TextStyle(fontSize: 11, color: AppColor.white))
            .intoExpanded(),
        StaticRatingBar(size: 13, rate: movieItem.rating.average / 2),
        SizedBox(width: 5),
        Text(movieItem.rating.average.toString(),
            style: TextStyle(fontSize: 11, color: AppColor.white)),
      ],
    ).intoContainer(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
    );
  }
}
