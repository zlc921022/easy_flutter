import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../../util/screen.dart';

class ActorDetailHead extends StatelessWidget {
  final String imageUrl;
  final String userName;

  ActorDetailHead(this.imageUrl, this.userName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(imageUrl),
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
        GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_white.png'),
        ).intoContainer(margin: EdgeInsets.only(left: 15, top: 15)),
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
                    imageUrl,
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
                userName,
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
