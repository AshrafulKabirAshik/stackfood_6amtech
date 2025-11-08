import 'package:stackfood_6amtech/features/home/view/home_view.dart';
import 'package:get/get.dart';
import '../../features/home/bindings.dart';
import '../../features/splash/bindings.dart';
import '../../features/splash/view/splash_view.dart';

class RouteService {
  static const splashView = '/splash';
  static const homeView = '/home';

  static final pages = [
    GetPage(name: splashView, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: homeView, page: () => const HomeView(), binding: HomeBinding()),
  ];
}
