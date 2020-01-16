import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_actor_detail.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';

/// 演员详情头部
class ActorDetailHead extends StatelessWidget {
  final MovieActorDetail actorDetail;

  ActorDetailHead(this.actorDetail);

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.width;
    double height = 228;
    return Stack(
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(actorDetail.avatars?.large),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        Opacity(
          opacity: 0.7,
          child: Container(
            color: AppColor.black,
            width: width,
            height: height,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: height,
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
