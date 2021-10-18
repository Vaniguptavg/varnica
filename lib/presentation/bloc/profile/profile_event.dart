part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  // ProfileEvent([List props = const <dynamic>[]]) : super();
}

class GetUserProfileEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}