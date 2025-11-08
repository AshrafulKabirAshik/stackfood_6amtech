import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GlobalValues extends GetxController {
  var packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '0.0.0',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  ).obs;

  var isDarkMode = false.obs;

  toggleBrightness(bool value) async {
    isDarkMode.value = value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }

  @override
  void onInit() {
    super.onInit();
    initPackageInfo();
  }

  initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo.value = info;
  }
}
