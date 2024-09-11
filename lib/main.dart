import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/features/product/product_page.dart';
import 'package:klontong/features/product/product_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  final Dio client = Dio();
  final ProductRepository productRepository = ProductRepository(client: client);
  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://7e5e9a53cbdc82b29e78968cbab71d76@o4507933971251200.ingest.de.sentry.io/4507933973151824';
      },
    );

    runApp(RepositoryProvider(
      create: (context) => productRepository,
      child: const KlontongApp(),
    ));
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class KlontongApp extends StatelessWidget {
  const KlontongApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductPage(),
    );
  }
}
