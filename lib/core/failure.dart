import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int statusCode;
  final String description;
  const Failure(
      {required this.message, this.statusCode = 0, this.description = ""});

  @override
  List<Object?> get props => [
        message,
        statusCode,
        description,
      ];
}
