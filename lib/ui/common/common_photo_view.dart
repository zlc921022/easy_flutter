import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider_mvvm/common/app_color.dart';

/// 通用图片查看控件
class CommonPhotoView extends StatefulWidget {
  final List<String> imageUrls;
  final PageController pageController;
  final int initIndex;

  CommonPhotoView({this.imageUrls, this.initIndex})
      : pageController = PageController(initialPage: initIndex);

  @override
  State<StatefulWidget> createState() {
    return new CommonPhotoViewState();
  }
}

class CommonPhotoViewState extends State<CommonPhotoView> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = this.widget.initIndex;
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              itemCount: this.widget.imageUrls.length,
              pageController: this.widget.pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChanged,
              loadingChild: CupertinoActivityIndicator(),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider:
                    CachedNetworkImageProvider(this.widget.imageUrls[index]),
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: '${this.widget.imageUrls[index]}/$index'));
              }),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${currentIndex + 1} /',
                    style: TextStyle(fontSize: 14, color: AppColor.white)),
                SizedBox(width: 3),
                Text(widget.imageUrls.length.toString(),
                    style: TextStyle(fontSize: 14, color: AppColor.white)),
              ],
            ),
          )
        ],
      ) ,
    );
  }
}
