import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/util/screen.dart';

class MyHeadImage extends StatelessWidget {
  String imageUrl =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578245221011&di=892757de61de9aa2a370a1c124f0f145&imgtype=0&src=http%3A%2F%2Fwww.dmyzw.com%2Fpicture%2Fb8c358776469c150a35d77d775d6c1d6.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 188,
          width: Screen.width,
          color: AppColor.black,
          child: Opacity(
            opacity: 0.7,
            child: Image(
              image: CachedNetworkImageProvider(imageUrl),
              width: Screen.width,
              height: 188,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(imageUrl),
              radius: 50.0,
            ),
            SizedBox(height: 10),
            Text('郑乐成',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
}
