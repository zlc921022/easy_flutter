import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';

/// 演职员
class MovieDetailCast extends StatelessWidget {
  final List<MovieActor> _actors;
  final List<MovieActor> _casts;
  List<MovieActor> casts;

  MovieDetailCast(this._actors, this._casts);

  @override
  Widget build(BuildContext context) {
    casts = [];
    for (MovieActor actor in _actors) {
      casts.add(actor);
    }
    for (MovieActor actor in _casts) {
      casts.add(actor);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('演职员'),
        SizedBox.fromSize(
          size: Size.fromHeight(110),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: (context, index) {
                var actor = casts[index];
                return _buildCastItem(context, actor, index);
              }),
        )
      ],
    );
  }

  Widget _buildCastItem(BuildContext context, MovieActor actor, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushActorDetail(context,actor.id);
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 15, right: index == casts.length - 1 ? 15 : 0),
        child: Column(
          children: <Widget>[
            ClipOval(
                child: Image.network(
              actor.avatars.small,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            )),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              width: 80,
              child: Text(actor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.white, fontSize: 14)),
            )
          ],
        ),
      ),
    );
  }
}
