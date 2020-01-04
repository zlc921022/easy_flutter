import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/app_navigator.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';

class MovieDetailCast extends StatelessWidget {
  String imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578131060001&di=62bc6f569470fbc8560d63b6124520d5&imgtype=0&src=http%3A%2F%2Fd-pic-image.yesky.com%2F740x-%2FuploadImages%2F2019%2F063%2F17%2FW439CK9H6693.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('演职员'),
        SizedBox.fromSize(
          size: Size.fromHeight(110),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildCastItem(context,'小文', index);
              }),
        )
      ],
    );
  }

  Widget _buildCastItem(BuildContext context,String name, int index) {
    return GestureDetector(
      onTap: (){
        AppNavigator.toActorDetail(context);
      },
      child:  Container(
        margin: EdgeInsets.only(left: 15, right: index == 9 ? 15 : 0),
        child: Column(
          children: <Widget>[
            ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                )),
            SizedBox(height: 10),
            Text(name, style: TextStyle(color: AppColor.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
