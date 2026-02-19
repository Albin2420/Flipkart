import 'dart:developer';
import 'package:flipkart/src/core/data_state/data_state.dart';
import 'package:flipkart/src/data/models/product_model/product_model.dart';
import 'package:flipkart/src/data/repositories/product_remote_repository_impl/product_remote_repository_impl.dart';
import 'package:flipkart/src/domain/repositories/product_remote_repository.dart/product_remote_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var state = DataState.initial.obs;
  final ProductRepository ptr = ProductRemoteRepositoryImpl();

  RxList<Product> productsList = <Product>[].obs;

  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchproduct();
  }

  Future<void> fetchproduct() async {
    try {
      state.value = DataState.loading;
      error.value = '';

      final res = await ptr.fetchproducts();

      res.fold(
        (l) {
          error.value = "Failed to load products";
          state.value = DataState.error;
          log("API ERROR: $l");
        },
        (R) {
          state.value = DataState.success;
          productsList.value = R["products"];
        },
      );
    } catch (e) {
      error.value = e.toString();
      state.value = DataState.error;
    }
  }
}
