import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_item.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/home_look_all_view.dart';
import 'package:flutter_movie/ui/common/home_section_title.dart';
import 'package:flutter_movie/ui/home/top_movie_item.dart';
import 'package:widget_chain/widget_chain.dart';
/// 影院热映
class HomeTopMovie extends StatelessWidget {

  List<MovieItem> topMovies;
  HomeTopMovie(this.topMovies);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeSectionTitle('影院热映'),
            HomeLookAllView(
              () {
                AppNavigator.pushMovieList(context,'影院热映','top_movie');
              },
            ).intoExpanded(),
          ],
        ),
        GridView.builder(
                shrinkWrap: true,
                itemCount: topMovies.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.55),
                itemBuilder: (context, index) {
                  var movie = topMovies[index];
                  return TopMovieItem(movie);
                })
            .intoContainer(margin: const EdgeInsets.all(12)),
      ],
    ).intoContainer(
      color: AppColor.white,
      margin: const EdgeInsets.only(bottom: 5)
    );
  }
}
