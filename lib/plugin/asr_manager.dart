import 'package:flutter/services.dart';

class AsrManager {
  MethodChannel _methodChannel = new MethodChannel('asr_plugin');

  /// 权限申请
  Future<void> requestPermission() async {
    return await _methodChannel.invokeMethod('requestPermission');
  }

  /// 开始识别
  Future<String> start({Map params}) async {
    return await _methodChannel.invokeMethod('start', params ?? {});
  }

  ///  停止识别
  Future<dynamic> stop() async {
    return await _methodChannel.invokeMethod('stop');
  }

  ///  取消识别
  Future<dynamic> cancel() async {
    return await _methodChannel.invokeMethod('cancel');
  }

  ///  释放资源
  Future<dynamic> release() async {
    return await _methodChannel.invokeMethod('release');
  }
}
