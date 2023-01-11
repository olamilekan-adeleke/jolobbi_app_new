import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures({required this.message, this.code, this.mainError});

  final String message;

  final String? mainError;

  final Object? code;

  @override
  List<Object?> get props => [message, code];
}
