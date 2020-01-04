import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommonPhotoView extends StatefulWidget {
  List<String> imageUrls;
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
    return Container(
      child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: this.widget.imageUrls.length,
          pageController: this.widget.pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: onPageChanged,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(this.widget.imageUrls[index]),
//                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(
                    tag: '${this.widget.imageUrls[index]}/$index'));
          }),
    );
  }
}
