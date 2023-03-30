part of 'add_address_bloc.dart';

abstract class AddAddressState extends Equatable {
  const AddAddressState();

  @override
  List<Object> get props => [];
}

class AddAddressInitial extends AddAddressState {}

class AddAddressLoading extends AddAddressState {}

class AddAddressError extends AddAddressState {
  final String message;

  const AddAddressError(this.message);

  @override
  List<Object> get props => [message];
}

class AddAddressSuccess extends AddAddressState {
  final BaseEntity baseEntity;

  const AddAddressSuccess(this.baseEntity);

  @override
  List<Object> get props => [baseEntity];
}
