
import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';
import 'package:widget_chain/widget_chain.dart';

class CommonIntroView extends StatelessWidget{

  final String intro;
  final bool expand;
  final GestureTapCallback _callback;
  CommonIntroView(this.intro,this.expand,this._callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('简介'),
        Text(
          intro,
          maxLines: expand ? null : 4,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 14,color: AppColor.white),
        ).intoContainer(margin: EdgeInsets.only(left: 15,right: 15,bottom: 5)),
        GestureDetector(
          onTap: (){
            _callback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                expand ? '收起' : '显示全部',
                style: TextStyle(fontSize: 14,color: AppColor.white),
              ),
              SizedBox(width: 5),
              Icon(expand ? Icons.expand_less : Icons.expand_more,color: AppColor.white,size: 20)
            ],
          ),
        )
      ],
    );
  }
}