import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_comment.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:flutter_movie/ui/common/static_rating_bar.dart';
import 'package:widget_chain/widget_chain.dart';

class MovieDetailComment extends StatelessWidget {
  final List<MovieComment> comments;

  MovieDetailComment(this.comments);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
        padding: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color(0x66000000),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonSectionTitle('短评'),
              Column(
                children: getData(),
              ),
            ]));
  }

  List<Widget> getData() {
    List<Widget> data = [];
    for (int i = 0; i < comments.length; i++) {
      data.add(_buildCommentItem(comments[i]));
    }
    return data;
  }

  Widget _buildCommentItem(MovieComment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                comment.author?.avatar,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(comment.author?.name,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    StaticRatingBar(size: 13, rate: comment.rating.value),
                    SizedBox(width: 5),
                    Text(comment.time,
                        style: TextStyle(fontSize: 12, color: AppColor.white)),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Text(comment.content,
            style: TextStyle(fontSize: 14, color: AppColor.white)),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(Icons.thumb_up, color: AppColor.white, size: 14),
            SizedBox(width: 5),
            Text(comment.usefulCount.toString(),
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
