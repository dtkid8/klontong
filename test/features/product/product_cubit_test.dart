import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_cubit.dart';
import 'package:klontong/features/product/product_response.dart';
import 'package:mocktail/mocktail.dart';
import 'mock.dart';
import 'mock_response.dart';

void main() {
  late ProductCubit cubit;
  late MockProductRepository productRepository;
  final mockListProductResponse = List<ProductResponse>.from(
      mockProductResponse.map((e) => ProductResponse.fromJson(e)));
  final mockListProduct = List<Product>.from(
      mockListProductResponse.map((e) => Product.fromResponse(e)));

  setUp(() {
    productRepository = MockProductRepository();
    cubit = ProductCubit(productRepository: productRepository);
  });

  group("Product Cubit Test", () {
    test('initial state should be initialize', () {
      expect(cubit.state, GenericInitializeState());
      expect(cubit.product, []);
      expect(cubit.errorMessage, "");
    });

    blocTest<ProductCubit, GenericState>(
      "Should emit [Loading,Loaded] when fetch data is success",
      build: () {
        when(() => productRepository.getProducts()).thenAnswer(
          (_) async => Right(
            mockListProduct,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [
        GenericLoadingState(),
        GenericLoadedState(
          mockListProduct,
        )
      ],
      verify: (cubit) {
        verify(() => productRepository.getProducts()).called(1);
        expect(cubit.product, equals(mockListProduct));
        expect(cubit.errorMessage, equals(''));
      },
    );
    blocTest<ProductCubit, GenericState>(
      "Should emit [Loading,Error] when fetch data is fail",
      build: () {
        when(() => productRepository.getProducts()).thenAnswer(
          (_) async => const Left(Failure(
              message: "Request Error", description: "", statusCode: 404)),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [
        GenericLoadingState(),
        const GenericErrorState("Request Error"),
      ],
      verify: (cubit) {
        verify(() => productRepository.getProducts()).called(1);
        expect(cubit.product, equals([]));
        expect(cubit.errorMessage, equals('Request Error'));
      },
    );

    blocTest<ProductCubit, GenericState>(
      'Should emit [Loading,Loaded] when load more is success',
      build: () {
        when(() => productRepository.getProducts(page: 2))
            .thenAnswer((_) async => Right(mockListProduct));
        return cubit;
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        GenericLoadingState(),
        GenericLoadedState(
          mockListProduct,
        )
      ],
      verify: (cubit) {
        verify(() => productRepository.getProducts(page: 2)).called(1);
        expect(cubit.product, equals(mockListProduct));
      },
    );

    blocTest<ProductCubit, GenericState>(
      'Should emit [Loading,Loaded] when refresh is success',
      build: () {
        when(() => productRepository.getProducts(page: 1))
            .thenAnswer((_) async =>
                Right(mockListProduct)); // Mock successful response
        return cubit;
      },
      act: (cubit) => cubit.refresh(),
      expect: () => [
        GenericLoadingState(),
        GenericLoadedState(
          mockListProduct,
        )
      ],
      verify: (cubit) {
        verify(() => productRepository.getProducts(page: 1)).called(1);
        expect(cubit.product, equals(mockListProduct));
      },
    );
  });
}
