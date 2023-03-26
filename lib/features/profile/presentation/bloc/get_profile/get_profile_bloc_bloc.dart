import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/failures/base.dart';
import '../../../../../cores/usecase/params.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/entities/user_details_entity.dart';
import '../../../domain/usecases/get_user_profile_usecase.dart';

part 'get_profile_bloc_event.dart';
part 'get_profile_bloc_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;

  UserDetailsEntity? _userDetailsEntity;
  UserDetailsEntity? get userDetailsEntity => _userDetailsEntity;

  GetProfileBloc({required this.getUserProfileUsecase})
      : super(GetProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(GetProfileLoading());

      Either<Failures, UserDetailsEntity> result = await getUserProfileUsecase(
        const NoParams(),
      );

      result.fold((l) {
        LoggerHelper.log(l.message);

        emit(GetProfileError(l.message));
      }, (r) {
        _userDetailsEntity = r;
        emit(GetProfileSuccess(r));
      });
    });
  }
}
