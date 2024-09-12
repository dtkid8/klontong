import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/core/url.dart';
import 'package:klontong/features/product/add/add_product_request.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_repository.dart';
import 'package:klontong/features/product/product_response.dart';
import 'package:mocktail/mocktail.dart';

import 'mock.dart';
import 'mock_response.dart';



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
      final url = "${Url.baseUrl}${Url.product}";
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
      final url = "${Url.baseUrl}${Url.product}";
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

  group('search Product', () {
    final mockListProductResponse = List<ProductResponse>.from(
        mockProductSearchResponse.map((e) => ProductResponse.fromJson(e)));
    final mockListProduct = List<Product>.from(
        mockListProductResponse.map((e) => Product.fromResponse(e)));

    test('should return list of products when response is success (200)',
        () async {
      // arrange
      const String query = "Taro";
      final url = "${Url.baseUrl}${Url.product}";

      final mockResponse = Response(
        requestOptions: RequestOptions(path: url),
        data: mockProductSearchResponse,
        statusCode: 200,
      );

      when(
        () => client.get(
          url,
          queryParameters: {
            "name": query,
          },
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final result = await productRepository.seacrhProduct(query: query);
      // assert
      expect(result, isA<Right<Failure, List<Product>>>());
      expect(result.fold((l) => null, (r) => r), equals(mockListProduct));
      verify(() => client.get(
            url,
            queryParameters: {
              "name": query,
            },
          )).called(1);
    });

    test('should return a Failure when the response code is 404 or other',
        () async {
      // arrange
      const String query = "Taro";
      final url = "${Url.baseUrl}${Url.product}";

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
            "name": query,
          },
        ),
      ).thenThrow((_) async => dioException);
      // act
      final result = await productRepository.seacrhProduct(query: query);
      // assert
      expect(result, isA<Left<Failure, List<Product>>>());
      expect(result.fold((l) => l, (r) => null), isA<Failure>());

      verify(() => client.get(
            url,
            queryParameters: {
              "name": query,
            },
          )).called(1);
    });
  });

  group('Add Product', () {
    final mockRequestAddProductResponse =
        AddProductRequest.fromMap(mockProductAddResponse);

    test('should return true when response is success (200)',
        () async {
      // arrange
      final url = "${Url.baseUrl}${Url.product}";

      final mockResponse = Response(
        requestOptions: RequestOptions(path: url),
        data: mockProductAddResponse,
        statusCode: 200,
      );

      when(
        () => client.post(
          url,
          data: mockRequestAddProductResponse.toMap(),
        ),
      ).thenAnswer((_) async => mockResponse);
      // act
      final result = await productRepository.addProduct(
          bodyRequest: mockRequestAddProductResponse);
      // assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.fold((l) => null, (r) => r), equals(true));
      verify(() => client.post(
            url,
            data: mockRequestAddProductResponse.toMap(),
          )).called(1);
    });

    test('should return a Failure when the response code is 404 or other',
        () async {
      // arrange
      final url = "${Url.baseUrl}${Url.product}";

      final dioException = DioException(
        requestOptions: RequestOptions(path: url),
        response: Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
        ),
      );

      when(
        () => client.post(
          url,
          data: mockRequestAddProductResponse.toMap(),
        ),
      ).thenThrow((_) async => dioException);
      // act
      final result = await productRepository.addProduct(
          bodyRequest: mockRequestAddProductResponse);
      // assert
      expect(result, isA<Left<Failure, bool>>());
      expect(result.fold((l) => l, (r) => null), isA<Failure>());

      verify(() => client.post(
            url,
            data: mockRequestAddProductResponse.toMap(),
          )).called(1);
    });
  });
}
