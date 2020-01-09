import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';
import 'package:flutter_movie/ui/common/common_section_title.dart';

/// 通用的简介 text折叠收起控件
class CommonIntroView extends StatelessWidget {
  final String summary;
  final bool expand;
  final GestureTapCallback _callback;

  CommonIntroView(this.summary, this.expand, this._callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonSectionTitle('简介'),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            (summary == '' || summary == null) ? '暂无数据' : summary,
            maxLines: expand ? null : 4,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 14, color: AppColor.white),
          ),
        ),
        _buildFoldView(),
      ],
    );
  }

  // 显示隐藏折叠
  Widget _buildFoldView() {
    if (summary == null || summary == '') {
      return Container();
    }
    return GestureDetector(
        onTap: () {
          _callback();
        },
        child: Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                expand ? '收起' : '显示全部',
                style: TextStyle(fontSize: 14, color: AppColor.white),
              ),
              SizedBox(width: 5),
              Icon(expand ? Icons.expand_less : Icons.expand_more,
                  color: AppColor.white, size: 20)
            ],
          ),
        ));
  }
}
