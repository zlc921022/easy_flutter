import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

const double kMaxRate = 5.0;
const int kNumberOfStarts = 5;
const double kSpacing = 3.0;
const double kSize = 50.0;

/// 通用评分星星组件
class CommonRatingBar extends StatelessWidget {
  // 星星数量
  final int count;

  // 初始化分数
  final double rate;

  // 亮的颜色
  final Color colorLight;

  // 暗的颜色
  final Color colorDark;
  final double size;

  CommonRatingBar({count, rate, colorLight, colorDark, this.size = kSize})
      : count = count ?? kNumberOfStarts,
        rate = rate ?? kMaxRate,
        colorLight = colorLight ?? new Color(0xffFF962E),
        colorDark = colorDark ?? new Color(0xffeeeeee);

  Widget buildStar() {
    return SizedBox(
      width: size * count,
      height: size,
      child: new CustomPaint(
        painter: new _PainterStars(
            size: this.size / 2,
            color: colorLight,
            style: PaintingStyle.fill,
            storkeWidth: 0.0),
      ),
    );
  }

  Widget buildHollowStar() {
    return new SizedBox(
      width: size * count,
      height: size,
      child: new CustomPaint(
        painter: new _PainterStars(
            size: this.size / 2,
            color: colorDark,
            style: PaintingStyle.fill,
            storkeWidth: 0.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        buildHollowStar(),
        new ClipRect(
          clipper: new _RatingbarClipper(width: rate * size),
          child: buildStar(),
        )
      ],
    );
  }
}

class _RatingbarClipper extends CustomClipper<Rect> {
  final double width;

  _RatingbarClipper({this.width}) : assert(width != null);

  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(_RatingbarClipper oldClipper) {
    return width != oldClipper.width;
  }
}

class _PainterStars extends CustomPainter {
  final double size;
  final Color color;
  final PaintingStyle style;
  final double storkeWidth;

  _PainterStars({this.size, this.color, this.storkeWidth, this.style});

  // 角度转弧度公式
  double degree2Radian(int degree) {
    return (Math.pi * degree / 180);
  }

  // 创建星星的path
  Path createStarPath(double radius, Path path) {
    // 36为五角星的角度
    double radian = degree2Radian(36);
    // 中间五边形的半径,太正不是很好看，扩大一点点
    double radius_in = (radius * Math.sin(radian / 2) / Math.cos(radian)) * 1.1;
    // 此点为多边形的起点
    path.moveTo((radius * Math.cos(radian / 2)), 0.0);
    path.lineTo((radius * Math.cos(radian / 2) + radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) * 2),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo(
        (radius * Math.cos(radian / 2) + radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) + radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo((radius * Math.cos(radian / 2)), (radius + radius_in));
    path.lineTo((radius * Math.cos(radian / 2) - radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo(
        (radius * Math.cos(radian / 2) - radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo(0.0, (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) - radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));

    path.lineTo((radius * Math.cos(radian / 2)), 0.0);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.strokeWidth = storkeWidth;
    paint.color = color;
    paint.style = style;

    double offset = storkeWidth > 0 ? storkeWidth + 2 : 0.0;

    Path path = new Path();
    path = createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = createStarPath(this.size - offset, path);

    if (offset > 0) {
      path = path.shift(new Offset(offset, offset));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PainterStars oldDelegate) {
    return oldDelegate.size != this.size;
  }
}
