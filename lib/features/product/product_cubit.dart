import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/product_repository.dart';

import 'product.dart';

class ProductCubit extends Cubit<GenericState> {
  int _page = 1;
  final List<Product> _product = [];
  List<Product> get product => _product;
  final ProductRepository productRepository;
  ProductCubit({required this.productRepository})
      : super(GenericInitializeState());

  void fetch() async {
    emit(GenericLoadingState());
    final result = await productRepository.getProducts(page: _page);
    result.fold((l) {
      emit(GenericErrorState(l.message));
    }, (r) {
      _product.addAll(r);
      emit(GenericLoadedState(_product));
      _page += 1;
    });
  }
}
