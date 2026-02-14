import 'package:flipkart/src/presentation/controller/home_controller/home_controller.dart';
import 'package:flipkart/src/presentation/widgets/product_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (width >= 600) crossAxisCount = 3;
    if (width >= 900) crossAxisCount = 4;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4CF0C),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),

        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search for products, brands and more",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error.value.isNotEmpty) {
            return Center(child: Text(controller.error.value));
          }

          if (controller.productsList.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          return RefreshIndicator(
            onRefresh: controller.fetchproduct,
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              itemCount: controller.productsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = controller.productsList[index];
                final bool isLastColumn = (index + 1) % crossAxisCount == 0;

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: isLastColumn
                          ? BorderSide.none
                          : BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: ProductCard(
                    imageUrl: product.image,
                    title: product.title,
                    price: product.price.toInt(),
                    originalPrice: product.price.toInt(),
                    discountPercent: 10,
                    rating: product.rating?.toInt() ?? 0,
                    deliveryText: "Delivered soon",
                    isLiked: false,
                    onTap: () {},
                    onLikeTap: () {},
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
