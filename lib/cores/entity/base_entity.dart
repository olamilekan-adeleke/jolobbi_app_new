import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final bool success;
  final String message;
  final dynamic data;

  const BaseEntity({required this.success, required this.message, this.data});

  @override
  List<Object?> get props => [success, message, data];
}

class BaseModel extends BaseEntity {
  const BaseModel({
    required bool success,
    required String message,
    dynamic data,
  }) : super(success: success, message: message, data: data);
}
