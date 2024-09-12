import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/features/product/product.dart';
import 'package:klontong/features/product/product_card_widget.dart';
import 'package:klontong/features/product/product_repository.dart';
import '../../../core/state.dart';
import 'search_product_cubit.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchProductCubit(
        productRepository: context.read<ProductRepository>(),
      ),
      child: const SearchProductView(),
    );
  }
}

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key});

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SearchProductCubit, GenericState>(
          builder: (context, state) {
            final List<Product> product =
                context.read<SearchProductCubit>().product;
            final String errorMessage =
                context.read<SearchProductCubit>().errorMessage;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  state is GenericErrorState && errorMessage.isNotEmpty
                      ? Text(errorMessage)
                      : const SizedBox.shrink(),
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Enter a product name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<SearchProductCubit>()
                                  .search(query: _searchController.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: product
                        .map(
                          (e) => ProductCardWidget(product: e),
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
    );
  }
}
