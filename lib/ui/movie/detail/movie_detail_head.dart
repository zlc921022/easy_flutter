import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:widget_chain/widget_chain.dart';

import '../../../util/screen.dart';

class MovieDetailHead extends StatelessWidget {
  final String imageUrl;

  MovieDetailHead(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Stack(
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
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                AppNavigator.back(context);
              },
              child: Image.asset('images/icon_arrow_back_white.png'),
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                CommonRoundedImage(imageUrl, width: 100, height: 134),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('美丽人生',
                        style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),
                    Text('2020',
                        style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    SizedBox(height: 5),
                    Text('9.5',
                        style: TextStyle(color: AppColor.white, fontSize: 10)),
                    SizedBox(height: 10),
                    Text(
                        '东临碣石，以观沧海。水何澹澹，山岛竦峙。树木丛生，百草丰茂。秋风萧瑟，洪波涌起。'
                        '日月之行，若出其中。星汉灿烂，若出其里。幸甚至哉，歌以咏志。',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColor.white, fontSize: 9)),
                  ],
                ).intoExpanded()
              ],
            )
          ],
        ).intoContainer(margin: const EdgeInsets.all(15)),
      ],
    );
  }
}
