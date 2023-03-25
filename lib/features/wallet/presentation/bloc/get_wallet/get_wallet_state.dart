part of 'get_wallet_bloc.dart';

abstract class GetWalletState extends Equatable {
  const GetWalletState();

  @override
  List<Object> get props => [];
}

class GetWalletInitial extends GetWalletState {}

class GetWalletLoading extends GetWalletState {}

class GetWalletSuccess extends GetWalletState {
  final WalletEntity wallet;
  const GetWalletSuccess({required this.wallet});

  @override
  List<Object> get props => [wallet];
}

class GetWalletError extends GetWalletState {
  final String message;
  const GetWalletError({required this.message});

  @override
  List<Object> get props => [message];
}
