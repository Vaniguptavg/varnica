import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp_demo/core/error/failures.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/core/utils/input_validator.dart';
import 'package:loginapp_demo/domain/entities/User.dart';
import 'package:loginapp_demo/domain/usecases/login_usecase.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_event.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';

  String forgotPasswordNumber = '';

  String password = '';

  bool isRememberMe = true;

  final LoginUsecase loginUseCase;

  final InputValidator inputValidator;

  void changeEmail(String email) {
    add(ChangeEmail(email));
  }

  void triggerRememberMe() {
    add(ChangeIsRememberMe());
  }

  void changePassword(String password) {
    add(ChangePassword(password));
  }

  void changeForgotPasswordNumber(String number) {
    add(ChangeForgotPasswordNumber(number));
  }

  void resetSuccess() {
    add(ResetSuccess());
  }

  void onLoginPressed(String fcmToken) {
    add(LoginUser(
      email: email,
      password: password,
      isRememberMe: isRememberMe,
      fcmToken: fcmToken,
    ));
  }

  LoginBloc({
    required LoginUsecase login,
    required this.inputValidator,
  })  : assert(login != null),
        assert(inputValidator != null),
        loginUseCase = login, super(LoginState.initial());

  @override
  LoginState get initialstate => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print('$event');
    if (event is ChangeEmail) {
      yield* _checkEmail(event.newEmail);
    } else if (event is ChangePassword) {
      yield* _checkPassword(event.newPassword);
    } else if (event is LoginUser) {
      _checkEmail(event.email);
      _checkPassword(event.password);
      yield LoginState.loading(state);
      final user = await loginUseCase.execute(LoginParams(
        email: event.email,
        password: event.password,
        isRememberMe: event.isRememberMe,
      ));
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is ChangeIsRememberMe) {
      isRememberMe = !state.isRememberMe!;
      yield state.rebuild((b) => b..isRememberMe = !b.isRememberMe!);
    } else if (event is ResetSuccess) {
      yield state.rebuild((b) => b..isSuccess = false);
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
      Either<Failure, User> failureOrTrivia,
      ) async* {
    yield failureOrTrivia.fold(
          (failure) => LoginState.loginError(state, _mapFailureToMessage(failure)),
          (trivia) => LoginState.success(state),
    );
  }

  int _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 3;
    }
  }

  Stream<LoginState> _checkEmail(String email) async* {
    print('number is $email');
    final inputEither = inputValidator.checkEmail(email);
    yield* inputEither.fold(
          (failure) async* {
        print('failure is $failure');
        yield LoginState.emailError(state);
      },
          (phoneNumber) async* {
        this.email = email;
        yield LoginState.noEmailError(state);
      },
    );
  }

  Stream<LoginState> _checkPassword(String password) async* {
    final inputEither = inputValidator.checkPassword(password);
    yield* inputEither.fold(
          (failure) async* {
        yield LoginState.passwordError(state);
      },
          (phoneNumber) async* {
        this.password = password;
        yield LoginState.noPasswordError(state);
      },
    );
  }
}