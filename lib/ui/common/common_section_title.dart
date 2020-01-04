import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/common/app_color.dart';

class CommonSectionTitle extends StatelessWidget {
  final String title;

  CommonSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Text(title,
          style: TextStyle(
              color: AppColor.white,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
    );
  }
}
