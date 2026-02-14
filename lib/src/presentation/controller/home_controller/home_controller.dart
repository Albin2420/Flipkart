import 'dart:developer';
import 'package:flipkart/src/data/models/product_model/product_model.dart';
import 'package:flipkart/src/data/repositories/product_remote_repository_impl/product_remote_repository_impl.dart';
import 'package:flipkart/src/domain/repositories/product_remote_repository.dart/product_remote_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository ptr = ProductRemoteRepositoryImpl();

  RxList<Product> productsList = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchproduct();
  }

  Future<void> fetchproduct() async {
    try {
      isLoading.value = true;
      error.value = '';

      final res = await ptr.fetchproducts();

      res.fold(
        (l) {
          error.value = "Failed to load products";
          log("API ERROR: $l");
        },
        (R) {
          productsList.value = R["products"];
        },
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
