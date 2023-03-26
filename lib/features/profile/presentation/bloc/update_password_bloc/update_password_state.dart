part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordError extends UpdatePasswordState {
  final String message;

  const UpdatePasswordError(this.message);
}

class UpdatePasswordSuccess extends UpdatePasswordState {
  final BaseEntity baseEntity;

  const UpdatePasswordSuccess(this.baseEntity);
}
