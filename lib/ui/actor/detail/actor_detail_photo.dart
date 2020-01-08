import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:widget_chain/widget_chain.dart';

class ActorPhotoView extends StatelessWidget {
  final List<MoviePhoto> photos;
  final String actorId;
  List<String> images;

  ActorPhotoView(this.photos, this.actorId);

  List<Widget> getData(BuildContext context) {
    images = [];
    List<Widget> data = [];
    for (int i = 0; i < photos.length; i++) {
      data.add(_buildPhotoItem(context, photos[i], i));
      images.add(photos[i].cover);
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
  Widget _buildPhotoItem(
      BuildContext context, MoviePhoto moviePhoto, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoViewGallery(context, images, index);
      },
      child:
          CommonRoundedImage(moviePhoto.cover, width: 120 / 0.75, height: 120),
    ).intoContainer(margin: const EdgeInsets.only(left: 15));
  }

  /// 查看更多
  Widget _buildLookMore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushPhotoList(context, '相册', action: 'photos', id: actorId);
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
