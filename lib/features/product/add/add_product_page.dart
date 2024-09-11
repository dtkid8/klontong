import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/features/product/add/add_input_property.dart';
import 'package:klontong/features/product/add/add_product_cubit.dart';
import 'package:klontong/features/product/add/add_product_request.dart';
import 'package:klontong/features/product/product_repository.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddProductCubit(productRepository: context.read<ProductRepository>()),
      child: const AddProductView(),
    );
  }
}

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final List<AddInputProperty> _input = [
    AddInputProperty(
      label: "Category Id",
      field: "categoryId",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Category Name",
      field: "categoryName",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "SKU",
      field: "sku",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Name",
      field: "name",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Description",
      field: "description",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Weight",
      field: "weight",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Width",
      field: "width",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Length",
      field: "length",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "height",
      field: "Height",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Image",
      field: "image",
      controller: TextEditingController(),
    ),
    AddInputProperty(
      label: "Harga",
      field: "harga",
      controller: TextEditingController(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: _input
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: e.controller,
                                decoration: InputDecoration(
                                  labelText: e.label,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter ${e.label}';
                                  }
                                  return null;
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AddProductCubit>().add(
                        request: AddProductRequest(
                          categoryId: int.parse(_input[0].controller.text),
                          categoryName: _input[1].controller.text,
                          sku: _input[2].controller.text,
                          name: _input[3].controller.text,
                          description: _input[4].controller.text,
                          weight: int.parse(_input[5].controller.text),
                          width: int.parse(_input[6].controller.text),
                          length: int.parse(_input[7].controller.text),
                          height: int.parse(_input[8].controller.text),
                          image: _input[9].controller.text,
                          harga: int.parse(_input[10].controller.text),
                        ),
                      );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
