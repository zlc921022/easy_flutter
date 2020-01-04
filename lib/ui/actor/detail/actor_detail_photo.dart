import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:widget_chain/widget_chain.dart';

class ActorPhotoView extends StatelessWidget {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578132145178&di=6f721a62b5e33b57659cdaeed7ced150&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fsoftbbs%2F1103%2F09%2Fc0%2F6952476_1299664187183_1024x1024soft.jpg";

  List<Widget> getData(BuildContext context) {
    List<Widget> data = [];
    for (int i = 0; i < 6; i++) {
      data.add(_buildPhotoItem(context,i));
    }
    data.add(_buildLookMore(context));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonSectionTitle('相册'),
          SizedBox.fromSize(
              size: Size.fromHeight(120),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getData(context),
              )).intoContainer(margin: const EdgeInsets.only(bottom: 15))
        ]);
  }

  /// 演员相册
  Widget _buildPhotoItem(BuildContext context,int initIndex) {
    List<String> images = [];
    for (int i = 0; i < 6; i++) {
      images.add(imageUrl);
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoViewGallery(context, images, initIndex);
      },
      child: CommonRoundedImage(imageUrl, width: 120 / 0.75, height: 120),
    ).intoContainer(margin: const EdgeInsets.only(left: 15));
  }

  /// 查看更多
  Widget _buildLookMore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoList(context, '相册');
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 8),
        child: Row(
          children: <Widget>[
            Text('查看更多', style: TextStyle(color: AppColor.white, fontSize: 12)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios, color: AppColor.white, size: 18),
          ],
        ),
      ),
    );
  }
}
