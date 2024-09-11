import 'package:flutter/material.dart';
import 'package:klontong/features/product/product.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail Product"),
      ),
      body: SingleChildScrollView(child: Column()),
    );
  }
}
