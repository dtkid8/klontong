import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/core/extension.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/product_repository.dart';
import '../product.dart';

class SearchProductCubit extends Cubit<GenericState> {
 List<Product> _product = [];
  List<Product> get product => _product;
  final ProductRepository productRepository;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  SearchProductCubit({required this.productRepository})
      : super(GenericInitializeState());


  void search({required String query}) async {
    emit(GenericLoadingState());
    final result = await productRepository.seacrhProduct(
        query: query.capitalizeEachWord());
    result.fold((l) {
      _errorMessage = l.message;
      emit(GenericErrorState(l.message));
    }, (r) {
      _product = r;
      emit(GenericLoadedState(product));
    });
  }
}