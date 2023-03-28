part of 'update_user_profile_bloc.dart';

abstract class UpdateUserProfileState extends Equatable {
  const UpdateUserProfileState();

  @override
  List<Object> get props => [];
}

class UpdateUserProfileInitial extends UpdateUserProfileState {}

class UpdateUserProfileLoading extends UpdateUserProfileState {}

class UpdateUserProfileError extends UpdateUserProfileState {
  final String message;

  const UpdateUserProfileError(this.message);
}

class UpdateUserProfileSuccess extends UpdateUserProfileState {
  final BaseEntity baseEntity;

  const UpdateUserProfileSuccess(this.baseEntity);
}
