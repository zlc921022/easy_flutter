import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';

/// 通用章节标题
class CommonSectionTitle extends StatelessWidget {
  final String title;

  CommonSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Text(title,
          style: TextStyle(
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
    );
  }
}
