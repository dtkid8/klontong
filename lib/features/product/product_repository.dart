import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_response.dart';

import '../../core/url.dart';

abstract class ProductRepositoryProtocol {
  Future<Either<Failure, List<Product>>> getProducts({int page = 1});
}

class ProductRepository extends ProductRepositoryProtocol {
  final Dio client;
  ProductRepository({required this.client});

  @override
  Future<Either<Failure, List<Product>>> getProducts({int page = 1}) async {
    try {
      final request = await client.get(
        "${Url.baseUrl}${Url.product}",
        queryParameters: {
          "page": page,
          "size": 5,
        },
      );
      final bool checkResponse =
          request.data != null && (request.statusCode ?? 0) == 200;
      if (checkResponse) {
        final List<ProductResponse> response = List<ProductResponse>.from(
            request.data.map((x) => ProductResponse.fromJson(x)));
        final List<Product> result =
            response.map((x) => Product.fromResponse(x)).toList();
        return Right(result);
      }
      return const Left(
        Failure(
          message: "General Error",
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          message: "Request Error",
          statusCode: e.response?.statusCode ?? 500,
          description: e.response?.data ?? "",
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          message: "General Error",
          description: e.toString(),
        ),
      );
    }
  }
}
