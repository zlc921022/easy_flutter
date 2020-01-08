import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor_detail.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../../util/screen.dart';

class ActorDetailHead extends StatelessWidget {

  final MovieActorDetail actorDetail;
  ActorDetailHead(this.actorDetail);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(actorDetail.avatars?.large),
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
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.center,
          height: 218,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Image(
                  image: CachedNetworkImageProvider(
                    actorDetail.avatars?.small,
                  ),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                actorDetail.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColor.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
