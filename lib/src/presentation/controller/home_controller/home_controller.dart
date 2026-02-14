import 'package:flipkart/src/data/repositories/product_remote_repository_impl/product_remote_repository_impl.dart';
import 'package:flipkart/src/domain/repositories/product_remote_repository.dart/product_remote_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ProductRepository ptr = ProductRemoteRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    fetchproduct();
  }

  Future<void> fetchproduct() async {
    ptr.fetchproducts();
  }
}
