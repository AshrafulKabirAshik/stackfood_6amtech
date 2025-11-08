import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stackfood_6amtech/features/home/model/banner_model.dart';
import 'package:stackfood_6amtech/features/home/model/category_model.dart';
import 'package:stackfood_6amtech/features/home/model/popular_food_model.dart';
import '../../../core/api/api_endpoint.dart';
import '../../../core/widgets/widget_snack_bar.dart';
import '/core/values/global_values.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalValues globalValues = Get.find();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  loadInitial() async {
    try {
      isLoading.value = true;
      await fetchBanner();
      await fetchCategory();
      await fetchPopularFood();
    } catch (e) {
      WidgetSnackBar.show(title: "Failed", message: "Exception : $e");
    } finally {
      isLoading.value = false;
    }
  }

  ///banner
  var bannerList = <BannerModel>[].obs;
  final PageController pageController = PageController(viewportFraction: 0.9);
  var currentPage = 0.obs;
  Timer? timer;
  var isSliderLoading = false.obs;
  bool _isWaitingToRestart = false;

  void startAutoSlide() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (bannerList.isEmpty) return;

      if (currentPage.value + 1 >= bannerList.length) {
        currentPage.value = 0;
      } else {
        currentPage.value += 1;
      }

      pageController.animateToPage(currentPage.value, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  void stopAutoSlide() async {
    if (_isWaitingToRestart) return;

    timer?.cancel();
    timer = null;

    _isWaitingToRestart = true;
    await Future.delayed(const Duration(seconds: 1));
    _isWaitingToRestart = false;

    if (Get.context!.mounted) {
      startAutoSlide();
    }
  }

  Future<void> fetchBanner() async {
    try {
      isLoading.value = true;
      debugPrint('${dotenv.env['API_BASE_URL']}${ApiEndpoint.bannerEndpoint}');

      final response = await http.get(
        Uri.parse('${dotenv.env['API_BASE_URL']}${ApiEndpoint.bannerEndpoint}'),

        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'zoneId': '[1]',
          'latitude': '23.735129',
          'longitude': '90.425614',
        },
      );

      //debugPrint('Response body : ${response.body}');
      //debugPrint("Status Code : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final List<dynamic> data = responseBody["banners"] as List<dynamic>;

        bannerList.clear();

        for (var element in data) {
          bannerList.add(BannerModel.fromJson(element));
        }

        startAutoSlide();
      } else {
        //final responseBody = jsonDecode(response.body);
      }
    } on SocketException {
      debugPrint("SocketException");

      return;
    } on HttpException {
      debugPrint("HttpException");
      return;
    } on FormatException {
      debugPrint("FormatException");
      return;
    } on TimeoutException {
      debugPrint("TimeoutException");
      return;
    } catch (e) {
      debugPrint("Exception : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  ///category
  var categoryList = <CategoryModel>[].obs;

  Future<void> fetchCategory() async {
    try {
      isLoading.value = true;
      debugPrint('${dotenv.env['API_BASE_URL']}${ApiEndpoint.categoryEndpoint}');

      final response = await http.get(
        Uri.parse('${dotenv.env['API_BASE_URL']}${ApiEndpoint.categoryEndpoint}'),

        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'zoneId': '[1]',
          'latitude': '23.735129',
          'longitude': '90.425614',
        },
      );

      //debugPrint('Response body : ${response.body}');
      //debugPrint("Status Code : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final List<dynamic> data = responseBody as List<dynamic>;

        categoryList.clear();

        for (var element in data) {
          categoryList.add(CategoryModel.fromJson(element));
        }

        startAutoSlide();
      } else {
        //final responseBody = jsonDecode(response.body);
      }
    } on SocketException {
      debugPrint("SocketException");

      return;
    } on HttpException {
      debugPrint("HttpException");
      return;
    } on FormatException {
      debugPrint("FormatException");
      return;
    } on TimeoutException {
      debugPrint("TimeoutException");
      return;
    } catch (e) {
      debugPrint("Exception : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  ///popular food
  var popularFoodList = <PopularFoodModel>[].obs;

  Future<void> fetchPopularFood() async {
    try {
      isLoading.value = true;
      debugPrint('${dotenv.env['API_BASE_URL']}${ApiEndpoint.popularFoodEndpoint}');

      final response = await http.get(
        Uri.parse('${dotenv.env['API_BASE_URL']}${ApiEndpoint.popularFoodEndpoint}'),

        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'zoneId': '[1]',
          'latitude': '23.735129',
          'longitude': '90.425614',
        },
      );

      //debugPrint('Response body : ${response.body}');
      //debugPrint("Status Code : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final List<dynamic> data = responseBody["products"] as List<dynamic>;

        popularFoodList.clear();

        for (var element in data) {
          popularFoodList.add(PopularFoodModel.fromJson(element));
        }
      } else {
        //final responseBody = jsonDecode(response.body);
      }
    } on SocketException {
      debugPrint("SocketException");

      return;
    } on HttpException {
      debugPrint("HttpException");
      return;
    } on FormatException {
      debugPrint("FormatException");
      return;
    } on TimeoutException {
      debugPrint("TimeoutException");
      return;
    } catch (e) {
      debugPrint("Exception : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
