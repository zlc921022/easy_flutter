import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:widget_chain/widget_chain.dart';

class MovieDetailComment extends StatelessWidget {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578135199158&di=2d7c66c3923b480937e7033a198ce527&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201512%2F29%2F20151229114315_TNwtx.thumb.700_0.jpeg";
  String userName = "小薇";
  String commentTime = "2020年1月4日";
  String comment =
      "有一个美丽的小女孩她的名字叫作小薇她有双温柔的眼睛她悄悄偷走我的心小薇啊你可知道我多爱你我要带你飞到天上去看那星星多美丽摘下一颗亲手送给你有一个美丽的小女孩";
  String agreeNum = "999";

  MovieDetailComment();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
        padding: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColor.black_66,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Opacity(
            opacity: 0.7,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonSectionTitle('短评'),
                  Column(
                    children: getDatas(),
                  ),
                ])));
  }

  List<Widget> getDatas() {
    List<Widget> data = [];
    for (int i = 0; i < 6; i++) {
      data.add(_buildCommentItem());
    }
    return data;
  }

  Widget _buildCommentItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(userName,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text(commentTime,
                    style: TextStyle(fontSize: 14, color: AppColor.white)),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Text(comment, style: TextStyle(fontSize: 14, color: AppColor.white)),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(Icons.thumb_up, color: AppColor.white, size: 14),
            SizedBox(width: 5),
            Text(agreeNum,
                style: TextStyle(fontSize: 14, color: AppColor.white)),
          ],
        ),
        SizedBox(height: 15),
        Divider(
          height: 1,
          color: AppColor.black_cc,
        ),
      ],
    ).intoContainer(padding: EdgeInsets.only(left: 10, right: 12, top: 12));
  }
}
