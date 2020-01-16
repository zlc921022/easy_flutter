import 'package:fluttertoast/fluttertoast.dart';
/// 吐司工具类
class ToastUtil {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}