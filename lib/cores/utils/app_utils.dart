import 'package:package_info_plus/package_info_plus.dart';

class AppUtils {
  static Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return "v ${packageInfo.version}+${packageInfo.buildNumber}";
  }
}
