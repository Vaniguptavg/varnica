import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super();
}

class LoginUser extends LoginEvent {
  final String email;
  final String password;
  final bool isRememberMe;
  final String fcmToken;

  LoginUser({
    required this.email,
    required this.password,
    required this.isRememberMe,
    required this.fcmToken,
  }) : super([email, password, isRememberMe, fcmToken]);

  @override
  String toString() {
    return '$email, $password, $isRememberMe, $fcmToken';
  }

  @override
  List<Object?> get props => [email,password,isRememberMe,fcmToken];
}

class ForgotPasswordEvent extends LoginEvent {
  final String number;

  ForgotPasswordEvent(this.number) : super([number]);

  @override
  List<Object?> get props => [number];
}

class ChangeEmail extends LoginEvent {
  final String newEmail;

  ChangeEmail(this.newEmail) : super([newEmail]);

  @override
  List<Object?> get props => [newEmail];
}

class ResetSuccess extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class ChangePassword extends LoginEvent {
  final String newPassword;

  ChangePassword(this.newPassword) : super([newPassword]);

  @override
  List<Object?> get props => [newPassword];
}

class ChangeIsRememberMe extends LoginEvent {
  ChangeIsRememberMe() : super();

  @override
  List<Object?> get props => [];
}

class ChangeForgotPasswordNumber extends LoginEvent {
  final String newNumber;

  ChangeForgotPasswordNumber(this.newNumber) : super([newNumber]);

  @override
  List<Object?> get props => [newNumber];
}