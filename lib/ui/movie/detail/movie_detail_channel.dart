import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';

/// 所属频道
class MovieDetailChannel extends StatelessWidget {

  final List tags;
  MovieDetailChannel(this.tags);

  Widget _buildChannelItem(String name,int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(left: 15,right: ( index == tags.length - 1 ? 15 : 0)),
        child: Row(
          children: <Widget>[
            Text(name, style: TextStyle(fontSize: 13, color: AppColor.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: AppColor.white, size: 16)
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0x66000000),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonSectionTitle('所属频道'),
          SizedBox.fromSize(
              size: Size.fromHeight(30),
              child: ListView.builder(
                  itemCount: tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildChannelItem(tags[index],index);
                  })),
        ]);
  }
}
