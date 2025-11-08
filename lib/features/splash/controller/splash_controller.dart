import 'package:stackfood_6amtech/core/routes/route.dart';

import '/core/values/global_values.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final GlobalValues globalValueController = Get.find();
  var isLogoAnimated = false.obs;
  var isNameAnimated = false.obs;
  var isVersionAnimated = false.obs;
  var isFooterAnimated = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  loadInitial() async {
    await Future.delayed(Duration(milliseconds: 300));
    isLogoAnimated.value = true;

    await Future.delayed(Duration(milliseconds: 300));
    isNameAnimated.value = true;

    await Future.delayed(Duration(milliseconds: 200));

    isVersionAnimated.value = true;

    await Future.delayed(Duration(milliseconds: 200));
    isFooterAnimated.value = true;

    goToAuthView();
  }

  void goToAuthView() {
    Get.offNamed(RouteService.homeView);
  }
}
