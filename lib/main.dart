import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/features/product/product_page.dart';
import 'package:klontong/features/product/product_repository.dart';

void main() {
  final Dio client = Dio();
  final ProductRepository productRepository = ProductRepository(client: client);

  runApp(RepositoryProvider(
    create: (context) => productRepository,
    child: const KlontongApp(),
  ));
}

class KlontongApp extends StatelessWidget {
  const KlontongApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductPage(),
    );
  }
}
