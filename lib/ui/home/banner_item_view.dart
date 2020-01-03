import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/util/toast.dart';
import 'package:widget_chain/widget_chain.dart';

class BannerItemView extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String zy;

  BannerItemView(this.imgUrl, this.title, this.zy);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Toast.show('banner点击了');
      },
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(imgUrl),
            fit: BoxFit.cover,
            width: Screen.width,
          ).intoClipRRect(
            borderRadius: BorderRadius.circular(3)
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColor.white)),
              SizedBox(height: 2),
              Text(zy,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: AppColor.white)),
            ],
          ).intoPositioned(left: 0, right: 0, top: 0, bottom: 30),
        ],
      ).intoContainer(margin: const EdgeInsets.symmetric(horizontal: 5)),
    );

  }
}
