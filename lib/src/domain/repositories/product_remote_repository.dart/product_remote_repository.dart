// abstact repo

import 'package:dartz/dartz.dart';
import 'package:flipkart/src/core/network/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Map<String, dynamic>>> fetchproducts();
}
