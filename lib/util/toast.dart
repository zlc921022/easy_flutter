import 'package:fluttertoast/fluttertoast.dart';
/// 吐司工具类
class Toast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}