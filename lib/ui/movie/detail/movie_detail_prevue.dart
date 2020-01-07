import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_photo.dart';
import 'package:flutter_movie/model/movie_trailer.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:flutter_movie/ui/movie/video_play_view.dart';
import 'package:widget_chain/widget_chain.dart';

class MovieDetailPrevue extends StatelessWidget {
  List<MovieTrailer> trailers;
  List<MoviePhoto> photos;
  List<String> imgUrls;
  String id;

  MovieDetailPrevue(this.trailers, this.photos, this.id);

  List<Widget> getData(BuildContext context) {
    List<Widget> data = [];
    imgUrls = [];
    for (MovieTrailer trailer in trailers) {
      data.add(_buildStillItem(context, trailer));
    }
    for (int i = 0; i < photos.length; i++) {
      data.add(_buildPhotoItem(context, photos[i], i));
      imgUrls.add(photos[i].cover);
    }
    data.add(_buildLookMore(context));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonSectionTitle('预告片 / 剧照'),
          SizedBox.fromSize(
              size: Size.fromHeight(120),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getData(context),
              )).intoContainer(margin: const EdgeInsets.only(bottom: 15))
        ]);
  }

  /// 电影预告片
  Widget _buildStillItem(BuildContext context, MovieTrailer trailer) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CommonRoundedImage(trailer.cover, width: 120 / 0.75, height: 120),
        GestureDetector(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new VideoPlayView();
            }));
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColor.black_cc,
              ),
              Icon(Icons.play_arrow, color: AppColor.white)
            ],
          ),
        )
      ],
    ).intoContainer(margin: EdgeInsets.only(left: 15));
  }

  /// 电影剧照
  Widget _buildPhotoItem(BuildContext context, MoviePhoto photo, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoViewGallery(context, imgUrls, index);
      },
      child: CommonRoundedImage(photo.cover, width: 120 / 0.75, height: 120),
    ).intoContainer(margin: const EdgeInsets.only(left: 15));
  }

  /// 查看更多
  Widget _buildLookMore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoList(context, '剧照');
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
