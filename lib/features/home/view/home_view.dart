import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_values.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.black,
          onRefresh: () async {
            await controller.loadInitial();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  SizedBox(height: AppValues.contentPadding * 2),
                  _buildTopBarView(context, controller),
                  SizedBox(height: AppValues.contentPadding * 2),
                  _buildSearchView(context, controller),
                  SizedBox(height: AppValues.contentPadding * 2),
                  _buildBannerView(context, controller),
                  SizedBox(height: AppValues.contentPadding * 2),
                  _buildCategoryView(context, controller),
                  SizedBox(height: AppValues.contentPadding * 4),
                  _buildPopularFoodView(context, controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTopBarView(BuildContext context, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
    child: Row(
      children: [
        Icon(Icons.home, color: Colors.grey),
        SizedBox(width: AppValues.contentPadding),
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            'House: 00, Road: 00, City-0000, Country',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey, fontFamily: 'FontBold'),
          ),
        ),
        SizedBox(width: AppValues.contentPadding),
        Icon(Icons.notifications_none_rounded),
      ],
    ),
  );
}

Widget _buildSearchView(BuildContext context, HomeController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
    child: Card(
      elevation: 4,
      shadowColor: Colors.black26,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(AppValues.childCornerRadius)),
      child: Padding(
        padding: const EdgeInsets.all(AppValues.contentPadding),
        child: Row(
          children: [
            Expanded(
              child: Text('Search food and restaurant hare...', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey)),
            ),
            SizedBox(width: AppValues.contentPadding),
            Icon(Icons.search_rounded, color: Colors.grey),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBannerView(BuildContext context, HomeController controller) {
  return Obx(() {
    return controller.isLoading.value
        ? SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator(color: Colors.green)),
          )
        : SizedBox(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.bannerList.length,
                    onPageChanged: (index) {
                      controller.currentPage.value = index;
                      controller.stopAutoSlide();
                    },

                    itemBuilder: (context, index) {
                      final banner = controller.bannerList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding / 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.childCornerRadius),
                          child: banner.imageFullUrl != null
                              ? Image.network(banner.imageFullUrl!, fit: BoxFit.cover, width: double.infinity)
                              : const Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: AppValues.contentPadding),

                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.bannerList.length, (index) {
                      final isActive = controller.currentPage.value == index;
                      return InkWell(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 24 : 6,
                          height: isActive ? 6 : 6,
                          decoration: BoxDecoration(color: isActive ? Colors.green : Colors.grey.shade400, borderRadius: BorderRadius.circular(16.0)),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
  });
}

Widget _buildCategoryView(BuildContext context, HomeController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
        child: Row(
          children: [
            Text('Categories', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: 'FontBold')),
            Spacer(),
            Text(
              'View All',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontFamily: 'FontBold',
                decoration: TextDecoration.underline,
                color: Colors.green,
                decorationColor: Colors.green,
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: AppValues.contentPadding),

      Obx(() {
        return controller.isLoading.value
            ? SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator(color: Colors.green)),
              )
            : SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = controller.categoryList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: AppValues.contentPadding * 2),
                      child: Column(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(AppValues.parentCornerRadius)),
                            child: category.imageFullUrl != null ? Image.network(category.imageFullUrl!) : const Icon(Icons.error),
                          ),
                          SizedBox(height: AppValues.contentPadding / 2),
                          Text(category.name ?? '-', style: Theme.of(context).textTheme.labelSmall!.copyWith()),
                        ],
                      ),
                    );
                  },
                ),
              );
      }),
    ],
  );
}

Widget _buildPopularFoodView(BuildContext context, HomeController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
        child: Row(
          children: [
            Text('Popular Food Nearby', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: 'FontBold')),
            Spacer(),
            Text(
              'View All',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontFamily: 'FontBold',
                decoration: TextDecoration.underline,
                color: Colors.green,
                decorationColor: Colors.green,
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: AppValues.contentPadding / 2),

      Obx(() {
        return controller.isLoading.value
            ? SizedBox(
                height: 240,
                child: Center(child: CircularProgressIndicator(color: Colors.green)),
              )
            : SizedBox(
                height: 240,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: controller.popularFoodList.length,
                  itemBuilder: (context, index) {
                    final product = controller.popularFoodList[index];
                    return Container(
                      width: 180,
                      height: 220,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(AppValues.contentPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusGeometry.circular(AppValues.parentCornerRadius),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: product.imageFullUrl != null
                                ? Image.network(product.imageFullUrl!, fit: BoxFit.cover, width: 200)
                                : const Icon(Icons.error),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(AppValues.contentPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name ?? '-', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: 'FontBold')),
                                  Text(
                                    product.restaurantName ?? '-',
                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: 'FontBold', color: Colors.grey),
                                  ),

                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${(product.price ?? 0.0).toString()}',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: 'FontBold', color: Colors.black),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.green, size: 16),
                                          SizedBox(width: AppValues.contentPadding / 2),
                                          Text(
                                            (product.ratingCount ?? 0.0).toStringAsFixed(1),
                                            style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: 'FontBold', color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      }),
    ],
  );
}
