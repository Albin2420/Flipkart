import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flipkart/src/core/network/failure.dart';
import 'package:flipkart/src/core/url.dart';
import 'package:flipkart/src/data/models/product_model/product_model.dart';
import 'package:flipkart/src/data/services/dio_services/dio_service.dart';
import 'package:flipkart/src/domain/repositories/product_remote_repository.dart/product_remote_repository.dart';

class ProductRemoteRepositoryImpl extends ProductRepository {
  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchproducts() async {
    final url = "${Url.baseUrl}/${Url.products}";

    try {
      final response = await DioClient.dio.get(url);
      if (response.statusCode == 200) {
        final products = (response.data as List)
            .map((e) => Product.fromJson(e))
            .toList();

        return right({"products": products});
      } else {
        return Left(Failure(message: "${response.statusMessage}"));
      }
    } on DioException catch (e) {
      log("❌ Dio error: ${e.message}");
      return left(
        Failure(
          message:
              e.response?.data?['detail']?.toString() ??
              "Something went wrong!",
        ),
      );
    } catch (e) {
      log("💥 Unexpected error: $e");
      return left(Failure(message: "$e"));
    }
  }
}
