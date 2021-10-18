part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  // const ProfileState();
  ProfileState([List props = const <dynamic>[]]) : super();

}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class Empty extends ProfileState {
  @override
  List<Object?> get props => [];
}

class Loading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class Loaded extends ProfileState {
  final UserModel trivia;

  Loaded({required this.trivia}) : super([trivia]);

  @override
  List<Object?> get props => [];
}

class Error extends ProfileState {
  final String message;

  Error({required this.message}) : super([message]);

  @override
  List<Object?> get props => [];
}