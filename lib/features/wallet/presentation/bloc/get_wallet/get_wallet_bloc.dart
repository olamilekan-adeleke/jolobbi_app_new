import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/usecase/params.dart';
import '../../../domain/entities/wallet_entity.dart';
import '../../../domain/usecases/get_wallet_usecase.dart';

part 'get_wallet_event.dart';
part 'get_wallet_state.dart';

class GetWalletBloc extends Bloc<GetWalletEvent, GetWalletState> {
  final GetWalletUsecase getWalletUsecase;

  GetWalletBloc({required this.getWalletUsecase}) : super(GetWalletInitial()) {
    on<GetWalletEvent>((event, emit) async {
      emit(GetWalletLoading());

      final result = await getWalletUsecase(const NoParams());

      result.fold(
        (failure) => emit(GetWalletError(message: failure.message)),
        (wallet) => emit(GetWalletSuccess(wallet: wallet)),
      );
    });
  }
}
