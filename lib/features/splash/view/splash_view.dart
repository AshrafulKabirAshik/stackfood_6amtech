import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_values.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppValues.contentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),

              Obx(() {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  opacity: controller.isLogoAnimated.value ? 1 : 0,
                  child: AnimatedSlide(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    offset: controller.isLogoAnimated.value ? Offset(0, 0) : Offset(0, 0.25),
                    child: Image.asset('assets/icon/icon.png', height: 140, width: 140, fit: BoxFit.cover),
                  ),
                );
              }),
              SizedBox(height: AppValues.contentPadding),
              Obx(() {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: controller.isNameAnimated.value ? 1 : 0,
                  child: AnimatedSlide(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    offset: controller.isNameAnimated.value ? Offset(0, 0) : Offset(0, 0.25),
                    child: Text(AppValues.userName, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: 'FontExtraBold')),
                  ),
                );
              }),

              Spacer(),
              Obx(() {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: controller.isVersionAnimated.value ? 1 : 0,
                  child: Text(
                    'Version : ${controller.globalValueController.packageInfo.value.version}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(),
                  ),
                );
              }),
              Obx(() {
                return SafeArea(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: controller.isFooterAnimated.value ? 1 : 0,
                    child: Text(AppValues.footer, style: Theme.of(context).textTheme.labelSmall!.copyWith()),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
