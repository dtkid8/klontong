import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/core/url.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_repository.dart';
import 'package:klontong/features/product/product_response.dart';
import 'package:mocktail/mocktail.dart';

import 'product_response_test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ProductRepository productRepository;
  late MockDio client;
  setUp(() {
    client = MockDio();
    productRepository = ProductRepository(client: client);
  });

  group('get Product', () {
    final mockListProductResponse = List<ProductResponse>.from(
        mockProductResponse.map((e) => ProductResponse.fromJson(e)));
    final mockListProduct = List<Product>.from(
        mockListProductResponse.map((e) => Product.fromResponse(e)));

    test('should return list of products when response is success (200)',
        () async {
      // arrange
      const url = "${Url.baseUrl}${Url.product}";
      const int page = 1;
      final mockResponse = Response(
        requestOptions: RequestOptions(path: url),
        data: mockProductResponse,
        statusCode: 200,
      );

      when(
        () => client.get(
          url,
          queryParameters: {
            "page": page,
            "size": 5,
          },
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final result = await productRepository.getProducts();
      // assert
      expect(result, isA<Right<Failure, List<Product>>>());
      expect(result.fold((l) => null, (r) => r), equals(mockListProduct));
      verify(() => client.get(
            url,
            queryParameters: {
              "page": page,
              "size": 5,
            },
          )).called(1);
    });

    test('should return a Failure when the response code is 404 or other',
        () async {
      // arrange
      const url = "${Url.baseUrl}${Url.product}";
      const int page = 1;
      final dioException = DioException(
        requestOptions: RequestOptions(path: url),
        response: Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
        ),
      );

      when(
        () => client.get(
          url,
          queryParameters: {
            "page": page,
            "size": 5,
          },
        ),
      ).thenThrow((_) async => dioException);
      // act
      final result = await productRepository.getProducts();
      // assert
      expect(result, isA<Left<Failure, List<Product>>>());
      expect(result.fold((l) => l, (r) => null), isA<Failure>());

      verify(() => client.get(
            url,
            queryParameters: {
              "page": page,
              "size": 5,
            },
          )).called(1);
    });
  });
}
