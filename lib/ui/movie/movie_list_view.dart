import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';

class MovieListView extends StatefulWidget {
  String imageUrl =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578135199158&di=2d7c66c3923b480937e7033a198ce527&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201512%2F29%2F20151229114315_TNwtx.thumb.700_0.jpeg';
  String action;
  String title;

  MovieListView(this.action, this.title);

  @override
  State<StatefulWidget> createState() {
    return new MovieListViewState();
  }
}

class MovieListViewState extends State<MovieListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Image.asset('images/icon_arrow_back_white.png'),
        ),
        title: Text(this.widget.title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.white)),
      ),
      body: Container(
          color: AppColor.white,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 16,
              itemBuilder: (context, index) {
                return _buildMovieListItem();
              })),
    );
  }

  Widget _buildMovieListItem() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: AppColor.white,
        margin: const EdgeInsets.only(left: 15, top: 15, right: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonRoundedImage(
                  this.widget.imageUrl,
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
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 100 / 0.75,
                  child: _buildRight(),
                )
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
    if (this.widget.action == 'top_movie') {
      // 即将上映
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.yellow,
          ),
          SizedBox(height: 20),
          Text(
            '收藏',
            style: TextStyle(fontSize: 14, color: Colors.yellow),
          )
        ],
      );
    } else {
      //影院热映
      return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColor.red, width: 1)),
        child: Text(
          '01月\n10日',
          style: TextStyle(fontSize: 14, color: AppColor.red),
        ),
      );
    }
  }
}
