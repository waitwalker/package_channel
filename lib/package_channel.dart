import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class PackageChannel {
  static const MethodChannel _channel =
      const MethodChannel('package_channel');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get getChannel async {
    if(Platform.isAndroid) {
      final String version = await _channel.invokeMethod('getChannel');
      return version;
    }
    return 'AppStore';
  }
}
