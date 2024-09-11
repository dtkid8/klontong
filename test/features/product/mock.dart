import 'package:dio/dio.dart';
import 'package:klontong/features/product/product_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockProductRepository extends Mock implements ProductRepository {}
