import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/util/toast.dart';
import 'package:widget_chain/widget_chain.dart';

class ComingMovieItem extends StatelessWidget {

  String imageUrl = 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3025940889,404287434&fm=26&gp=0.jpg';

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Toast.show('点击进入电影详情');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonRoundedImage(imageUrl).intoExpanded(),
          SizedBox(height: 2),
          Text('美丽人生',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 14)),
          SizedBox(height: 2),
          Text('10000人想看',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: AppColor.black_99)),
          SizedBox(height: 4),
          Text('01月10日', style: TextStyle(fontSize: 10, color: AppColor.red))
              .intoContainer(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border:Border.all(width: 1,color: AppColor.red),
              )
          )
        ],
      ),
    );
  }
}
