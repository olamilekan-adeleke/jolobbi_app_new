import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/usecase/params.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/usecases/get_user_address_usecase.dart';

part 'get_address_bloc_event.dart';
part 'get_address_bloc_state.dart';

class GetAddressBlocBloc
    extends Bloc<GetAddressBlocEvent, GetAddressBlocState> {
  final GetUserAddressUsecase getUserAddressUsecase;

  GetAddressBlocBloc({
    required this.getUserAddressUsecase,
  }) : super(GetAddressBlocInitial()) {
    on<GetAddressBlocEvent>((event, emit) async {
      emit(GetAddressBlocLoading());

      final result = await getUserAddressUsecase(const NoParams());

      result.fold(
        (l) => emit(GetAddressBlocError(message: l.message)),
        (r) => emit(GetAddressBlocSuccess(addresses: r)),
      );
    });
  }
}
