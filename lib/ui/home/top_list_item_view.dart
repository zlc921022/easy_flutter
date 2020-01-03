import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/util/toast.dart';
import 'package:widget_chain/widget_chain.dart';

class TopListItemView extends StatelessWidget {
  final String imgUrl;

  TopListItemView(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Toast.show('item点击了');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image(
                image: CachedNetworkImageProvider(imgUrl),
                fit: BoxFit.cover,
                width: Screen.width,
                height: 110,
              ).intoClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(3),topRight: Radius.circular(3)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Text('每周五更新10部',style: TextStyle(fontSize: 14,color: AppColor.black_33)),
                  SizedBox(height: 15),
                  Text('一周口碑电影榜',style: TextStyle(fontSize: 18,color: AppColor.black_33,fontWeight: FontWeight.bold)),
                ],
              ).intoContainer(margin: const EdgeInsets.only(left: 20))
            ],
          ),
          Stack(
            children: <Widget>[
              Container(
                color: AppColor.red,
                height: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                )
              )
            ],
          )
        ],
      ).intoContainer(margin: EdgeInsets.symmetric(horizontal: 5))
    );

  }
}
