import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_rounded_image.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';

class ActorWorksView extends StatelessWidget {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578138527882&di=ff4b1b2b5c96eeac744ef6771d670adc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F6%2F89%2F77ca313194.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('影视作品'),
        SizedBox.fromSize(
          size: Size.fromHeight(180),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildWorksItem(context, index);
              }),
        )
      ],
    );
  }

  Widget _buildWorksItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toMovieDetail(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: (index == 7) ? 15 : 0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonRoundedImage(imageUrl, width: 100, height: 100 / 0.75),
            SizedBox(height: 5),
            Text('岁月', style: TextStyle(fontSize: 14, color: AppColor.white)),
            SizedBox(height: 5),
            Text('9.0', style: TextStyle(fontSize: 12, color: AppColor.white)),
          ],
        ),
      ),
    );
  }
}
