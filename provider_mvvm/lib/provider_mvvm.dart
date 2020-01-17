import 'package:flutter/services.dart';

class ProviderMvvm {
  static const MethodChannel _channel =
  const MethodChannel('provider_mvvm');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}