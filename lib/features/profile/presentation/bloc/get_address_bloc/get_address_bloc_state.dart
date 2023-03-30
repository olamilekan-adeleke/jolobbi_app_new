part of 'get_address_bloc_bloc.dart';

abstract class GetAddressBlocState extends Equatable {
  const GetAddressBlocState();

  @override
  List<Object> get props => [];
}

class GetAddressBlocInitial extends GetAddressBlocState {}

class GetAddressBlocLoading extends GetAddressBlocState {}

class GetAddressBlocError extends GetAddressBlocState {
  final String message;

  const GetAddressBlocError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetAddressBlocSuccess extends GetAddressBlocState {
  final List<AddressEntity> addresses;

  const GetAddressBlocSuccess({required this.addresses});

  @override
  List<Object> get props => [addresses];
}
