import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../data/models/address_model.dart';
import '../../../domain/usecases/add_address_usecase.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddAddressUsecase addAddressUsecase;

  AddAddressBloc({required this.addAddressUsecase})
      : super(AddAddressInitial()) {
    on<AddAddressEvent>((event, emit) async {
      emit(AddAddressLoading());

      final result = await addAddressUsecase(event.address);

      result.fold(
        (failure) => emit(AddAddressError(failure.message)),
        (success) => emit(AddAddressSuccess(success)),
      );
    });
  }
}
