import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:provider_mvvm/common/app_color.dart';

///演员相册
class ActorPhotoView extends StatelessWidget {
  final List<MoviePhoto> photos;
  final String actorId;
  List<String> images;

  ActorPhotoView(this.photos, this.actorId);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonSectionTitle('相册'),
            SizedBox.fromSize(
                size: Size.fromHeight(photos.length == 0 ? 50 : 120),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getData(context),
                ))
          ]),
    );
  }

  List<Widget> getData(BuildContext context) {
    images = [];
    List<Widget> data = [];
    if (photos.length == 0) {
      Container empty = new Container(
        margin: const EdgeInsets.only(left: 15),
        child: new Text('暂无相册',
            style: TextStyle(color: AppColor.white, fontSize: 14)),
      );
      data.add(empty);
      return data;
    }
    for (int i = 0; i < photos.length; i++) {
      data.add(_buildPhotoItem(context, photos[i], i));
      images.add(photos[i].cover);
    }
    data.add(_buildLookMore(context));
    return data;
  }

  /// 演员相册
  Widget _buildPhotoItem(
      BuildContext context, MoviePhoto moviePhoto, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          AppNavigator.toPhotoViewGallery(context, images, index);
        },
        child: CommonRoundedImage(moviePhoto.cover,
            width: 120 / 0.75, height: 120),
      ),
    );
  }

  /// 查看更多
  Widget _buildLookMore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushPhotoList(context, '相册',
            action: 'photos', id: actorId);
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
