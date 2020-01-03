
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:widget_chain/widget_chain.dart';

class HeadBannerItem extends StatelessWidget{

  final String imageUrl;
  final String title;
  final String zy;
  HeadBannerItem(this.imageUrl,this.title,this.zy);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: CachedNetworkImage(imageUrl: imageUrl),
          borderRadius: BorderRadius.circular(4),
        ).intoContainer(width: Screen.width,height: 120),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,style: TextStyle(color: AppColor.white,fontSize: 15,fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(zy,style: TextStyle(color: AppColor.white,fontSize: 14)),
          ],
        )
      ],
    ).intoContainer(margin: const EdgeInsets.all(10));
  }
}