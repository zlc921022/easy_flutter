import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/common/app_color.dart';
import 'package:provider_mvvm/utils/screen_util.dart';

class HeadBannerItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String zy;

  HeadBannerItem(this.imageUrl, this.title, this.zy);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
              width: ScreenUtil.width,
              height: 120,
              child: ClipRRect(
                child: CachedNetworkImage(imageUrl: imageUrl),
                borderRadius: BorderRadius.circular(4),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(zy, style: TextStyle(color: AppColor.white, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
