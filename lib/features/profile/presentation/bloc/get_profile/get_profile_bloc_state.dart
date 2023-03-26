part of 'get_profile_bloc_bloc.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileError extends GetProfileState {
  final String message;

  const GetProfileError(this.message);
}

class GetProfileSuccess extends GetProfileState {
  final UserDetailsEntity userDetailsEntity;

  const GetProfileSuccess(this.userDetailsEntity);
}
