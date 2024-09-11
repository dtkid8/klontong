import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_response.dart';
import 'package:klontong/features/product/search/search_product_cubit.dart';
import 'package:mocktail/mocktail.dart';
import '../mock.dart';
import '../mock_response.dart';

void main() {
  late SearchProductCubit cubit;
  late MockProductRepository productRepository;
  final mockListProductResponse = List<ProductResponse>.from(
      mockProductSearchResponse.map((e) => ProductResponse.fromJson(e)));
  final mockListProduct = List<Product>.from(
      mockListProductResponse.map((e) => Product.fromResponse(e)));
  const String query = "Taro";
  setUp(() {
    productRepository = MockProductRepository();
    cubit = SearchProductCubit(productRepository: productRepository);
  });

  group("Search Product Cubit Test", () {
    test('initial state should be initialize', () {
      expect(cubit.state, GenericInitializeState());
      expect(cubit.product, []);
      expect(cubit.errorMessage, "");
    });

    blocTest<SearchProductCubit, GenericState>(
      "Should emit [Loading,Loaded] when fetch data is success",
      build: () {
        when(() => productRepository.seacrhProduct(query: query)).thenAnswer(
          (_) async => Right(
            mockListProduct,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.search(query: query),
      expect: () => [
        GenericLoadingState(),
        GenericLoadedState(
          mockListProduct,
        )
      ],
      verify: (cubit) {
        verify(() => productRepository.seacrhProduct(query: query)).called(1);
      },
    );
    blocTest<SearchProductCubit, GenericState>(
      "Should emit [Loading,Error] when fetch data is fail",
      build: () {
        when(() => productRepository.seacrhProduct(query: query)).thenAnswer(
          (_) async => const Left(Failure(
              message: "Request Error", description: "", statusCode: 404)),
        );
        return cubit;
      },
      act: (cubit) => cubit.search(query: query),
      expect: () => [
        GenericLoadingState(),
        const GenericErrorState("Request Error"),
      ],
      verify: (cubit) {
        verify(() => productRepository.seacrhProduct(query: query)).called(1);
      },
    );
  });
}
