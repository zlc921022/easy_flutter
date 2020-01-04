import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_title_view.dart';

class ActorPhotosView extends StatelessWidget {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578143780608&di=8e2e3865a39a5150199152dc5c8e47ac&imgtype=0&src=http%3A%2F%2Fimg.blog.163.com%2Fphoto%2FoAGG0D7Sc0elME-hgdDY2w%3D%3D%2F4581005245966732952.jpg";
  final String title;

  ActorPhotosView(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, title),
      body: GridView.builder(
          itemCount: 18,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
          itemBuilder: (context, index) {
            return _buildPhotoItem(context, index);
          }),
    );
  }

  Widget _buildPhotoItem(BuildContext context, int index) {
    List<String> imageUrls = [];
    for (int i = 0; i < 18; i++) {
      imageUrls.add(imageUrl);
    }
    return GestureDetector(
      onTap: () {
        AppNavigator.toPhotoViewGallery(context, imageUrls, index);
      },
      child: Image(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
