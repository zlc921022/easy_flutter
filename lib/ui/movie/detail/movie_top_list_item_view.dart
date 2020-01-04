import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';

class MovieTopListItemView extends StatelessWidget {
  final String imageUrl;

  MovieTopListItemView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toMovieDetail(context);
      },
      child: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(left: 15, top: 15, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text('No.1',
                  style: TextStyle(color: AppColor.white, fontSize: 14)),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonRoundedImage(
                  this.imageUrl,
                  width: 100,
                  height: 100 / 0.75,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text('野猪',
                        style: TextStyle(
                            color: AppColor.black_33,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 10),
                    Text('8.8',
                        style:
                            TextStyle(color: AppColor.black_99, fontSize: 12)),
                    SizedBox(height: 10),
                    Text(
                        '2019 / 剧情 家庭 / 王子异\n'
                        '郑乐成',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: AppColor.black_99, fontSize: 14)),
                  ],
                )),
                _buildRight(),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: AppColor.black_cc,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRight() {
    return Container(
      width: 40,
      height: 100 / 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.yellow,
          ),
          SizedBox(height: 12),
          Text(
            '收藏',
            style: TextStyle(fontSize: 14, color: Colors.yellow),
          )
        ],
      ),
    );
  }
}
