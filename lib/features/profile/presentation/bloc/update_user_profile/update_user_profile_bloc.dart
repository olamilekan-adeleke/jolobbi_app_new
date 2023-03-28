import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/entity/base_entity.dart';
import '../../../../../cores/failures/base.dart';
import '../../../domain/usecases/update_user_profile_usecase.dart';

part 'update_user_profile_event.dart';
part 'update_user_profile_state.dart';

class UpdateUserProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateUserProfileState> {
  final UpdateUserProfileUsecase updateUserProfileUsecase;

  UpdateUserProfileBloc({
    required this.updateUserProfileUsecase,
  }) : super(UpdateUserProfileInitial()) {
    on<UpdateUserProfileEvent>((event, emit) async {
      emit(UpdateUserProfileLoading());

      final Either<Failures, BaseEntity> result =
          await updateUserProfileUsecase(event.data);

      result.fold((l) {
        emit(UpdateUserProfileError(l.message));
      }, (r) {
        emit(UpdateUserProfileSuccess(r));
      });
    });
  }
}
