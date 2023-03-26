part of 'update_user_profile_bloc.dart';

class UpdateUserProfileEvent extends Equatable {
  final Map<String, dynamic> data;

  const UpdateUserProfileEvent(this.data);

  @override
  List<Object> get props => [data];
}
