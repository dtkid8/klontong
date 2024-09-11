import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/features/product/add/add_product_page.dart';
import 'package:klontong/features/product/detail/detail_product_page.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_cubit.dart';
import 'package:klontong/features/product/product_repository.dart';

import '../../core/state.dart';
import 'search/search_product_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(productRepository: context.read<ProductRepository>()),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    context.read<ProductCubit>().fetch();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      context.read<ProductCubit>().fetch();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Product"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchProductPage()));
            },
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: BlocBuilder<ProductCubit, GenericState>(
          builder: (context, state) {
            final List<Product> product = context.read<ProductCubit>().product;
            final String errorMessage =
                context.read<ProductCubit>().errorMessage;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  state is GenericErrorState && errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : const SizedBox.shrink(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: product
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailProductPage(
                                    product: e,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: e.image,
                                    errorWidget: (context, url, error) =>
                                        const SizedBox.shrink(),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                  ),
                                  Text(e.name),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  state is GenericLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
