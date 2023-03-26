part of 'update_password_bloc.dart';

class UpdatePasswordEvent extends Equatable {
  final String email;

  const UpdatePasswordEvent(this.email);

  @override
  List<Object> get props => [];
}
