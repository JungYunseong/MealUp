import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:meal_up/utils/platform_utils.dart';
import 'package:path_provider/path_provider.dart';

class AppInstallDate {
  const AppInstallDate._();
  factory AppInstallDate() => _instance;

  static const _instance = AppInstallDate._();

  static const MethodChannel _channel = MethodChannel('app_install_date');

  Future<DateTime> get installDate async {
    if (PlatformUtils.isAndroid) {
      final installDateInMilliseconds =
          await _channel.invokeMethod<int>('getInstallDate');
      if (installDateInMilliseconds != null) {
        return DateTime.fromMillisecondsSinceEpoch(installDateInMilliseconds);
      } else {
        throw FailedToGetInstallDateException(
            'Install time from platform is null');
      }
    } else {
      return _getInstallDate();
    }
  }

  Future<DateTime> _getInstallDate() async {
    var applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    var stat = await FileStat.stat(applicationDocumentsDirectory.path);
    return stat.accessed;
  }
}

/// This exception is thrown when it is failed to get install date
class FailedToGetInstallDateException {
  FailedToGetInstallDateException(this.reason);

  final String reason;

  @override
  String toString() => reason;
}