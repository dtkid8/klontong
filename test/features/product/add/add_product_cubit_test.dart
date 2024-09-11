import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/core/failure.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/add/add_product_cubit.dart';
import 'package:klontong/features/product/add/add_product_request.dart';
import 'package:mocktail/mocktail.dart';
import '../mock.dart';
import '../mock_response.dart';

void main() {
  late AddProductCubit cubit;
  late MockProductRepository productRepository;
  final mockRequestAddProductResponse =
      AddProductRequest.fromMap(mockProductAddResponse);

  setUp(() {
    productRepository = MockProductRepository();
    cubit = AddProductCubit(productRepository: productRepository);
  });

  group("Add Product Cubit Test", () {
    test('initial state should be initialize', () {
      expect(cubit.state, GenericInitializeState());
      expect(cubit.errorMessage, "");
    });

    blocTest<AddProductCubit, GenericState>(
      "Should emit [Loading,Loaded] when post data is success",
      build: () {
        when(() => productRepository.addProduct(
            bodyRequest: mockRequestAddProductResponse)).thenAnswer(
          (_) async => const Right(
            true,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.add(request: mockRequestAddProductResponse),
      expect: () => [
        GenericLoadingState(),
        const GenericLoadedState(
          true,
        )
      ],
      verify: (cubit) {
        verify(() => productRepository.addProduct(bodyRequest: mockRequestAddProductResponse)).called(1);
      },
    );
    blocTest<AddProductCubit, GenericState>(
      "Should emit [Loading,Error] when post data is fail",
      build: () {
        when(() => productRepository.addProduct(
            bodyRequest: mockRequestAddProductResponse)).thenAnswer(
          (_) async => const Left(Failure(
              message: "Request Error", description: "", statusCode: 404)),
        );
        return cubit;
      },
      act: (cubit) => cubit.add(request: mockRequestAddProductResponse),
      expect: () => [
        GenericLoadingState(),
        const GenericErrorState("Request Error"),
      ],
      verify: (cubit) {
        verify(() => productRepository.addProduct(bodyRequest: mockRequestAddProductResponse)).called(1);
      },
    );
  });
}
