import 'package:flipkart/src/presentation/controller/home_controller/home_controller.dart';
import 'package:flipkart/src/presentation/widgets/product_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 26,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF010048)),
                  Text(
                    "Getting your products ready 📦 ...",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF010048),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.error.value.isNotEmpty) {
            return Center(
              child: Text(
                controller.error.value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            );
          }

          if (controller.productsList.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          return RefreshIndicator(
            color: const Color(0xFF010048),
            backgroundColor: Colors.white,
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
                    originalPrice: product.price.toInt(),
                    discountPercent: 10,
                    price: ((product.price.toInt() * (100 - 10)) / 100).round(),
                    rating: product.rating.toInt(),
                    deliveryText: "Delivered soon",
                    ratingCount: product.ratingCount,
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
