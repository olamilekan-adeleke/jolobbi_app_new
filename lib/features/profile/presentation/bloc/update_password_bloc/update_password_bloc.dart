import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../../../cores/failures/base.dart';
import '../../../domain/usecases/update_password_usecase.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UpdatePasswordUsecase updatePasswordUsecase;

  UpdatePasswordBloc({
    required this.updatePasswordUsecase,
  }) : super(UpdatePasswordInitial()) {
    on<UpdatePasswordEvent>((event, emit) async {
      emit(UpdatePasswordLoading());

      final Either<Failures, BaseEntity> result = await updatePasswordUsecase(
        event.email,
      );

      result.fold(
        (Failures failure) => emit(UpdatePasswordError(failure.message)),
        (BaseEntity baseEntity) => emit(UpdatePasswordSuccess(baseEntity)),
      );
    });
  }
}
