import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:flutter_movie/ui/movie/detail/movie_top_list_view.dart';
import 'package:flutter_movie/util/screen.dart';
import 'package:flutter_movie/util/toast.dart';
import 'package:widget_chain/widget_chain.dart';

class TopListItemView extends StatelessWidget {
  final String imgUrl;

  TopListItemView(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Toast.show('item点击了');
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return new MovieTopListView();
          }));
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
                  height: 96,
                ).intoClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Text('每周五更新10部',
                        style:
                            TextStyle(fontSize: 14, color: AppColor.black_33)),
                    SizedBox(height: 15),
                    Text('一周口碑电影榜',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColor.black_33,
                            fontWeight: FontWeight.bold)),
                  ],
                ).intoContainer(margin: const EdgeInsets.only(left: 20))
              ],
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return _buildListItem(index);
                  },
                ),
                decoration: new BoxDecoration(
                  color: AppColor.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3)),
                ),
              ),
            )
          ],
        ).intoContainer(margin: EdgeInsets.symmetric(horizontal: 5)));
  }

  Widget _buildListItem(int index) {
    return Row(
      children: <Widget>[
        Text('$index. 杀手预言',
                style: TextStyle(fontSize: 10, color: AppColor.white))
            .intoExpanded(),
        StaticRatingBar(size: 13,rate: 4.0),
        SizedBox(width: 5),
        Text('8.8', style: TextStyle(fontSize: 10, color: AppColor.white)),
      ],
    ).intoContainer(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
    );
  }
}
