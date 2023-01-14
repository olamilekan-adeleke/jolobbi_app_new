import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../cores/failures/base.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../presentation.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUsecase _signUpUsecase;

  SignUpBloc({required SignUpUsecase signUpUsecase})
      : _signUpUsecase = signUpUsecase,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());

      final Either<Failures, AuthResultEntity> result =
          await _signUpUsecase(event.signUpFormModel);

      result.fold((l) {
        emit(SignUpError(l.message));
      }, (r) {
        emit(SignUpSuccess());
      });
    });
  }
}
