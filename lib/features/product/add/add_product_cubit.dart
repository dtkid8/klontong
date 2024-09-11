import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/core/state.dart';
import 'package:klontong/features/product/add/add_product_request.dart';
import 'package:klontong/features/product/product_repository.dart';

class AddProductCubit extends Cubit<GenericState> {
  final ProductRepository productRepository;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  AddProductCubit({required this.productRepository})
      : super(GenericInitializeState());

  void add({required AddProductRequest request}) async {
    emit(GenericLoadingState());
    final result = await productRepository.addProduct(bodyRequest: request);
    result.fold((l) {
      _errorMessage = l.message;
      emit(GenericErrorState(l.message));
    }, (r) {
      emit(GenericLoadedState(r));
    });
  }
}
