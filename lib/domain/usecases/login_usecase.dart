import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loginapp_demo/core/error/failures.dart';
import 'package:loginapp_demo/core/usecase/usecase.dart';
import 'package:loginapp_demo/domain/entities/User.dart';
import 'package:loginapp_demo/domain/repositories/login_repository.dart';

class LoginUsecase extends UseCase<User,LoginParams>{
  final LoginRepository repository;

  LoginUsecase({required this.repository}): assert (repository!=null);

  @override
  Future<Either<Failure, User>> execute(LoginParams params) async {
    return await repository.loginUser(params.email, params.password,
         params.isRememberMe);
  }

}

class LoginParams extends Equatable {
  final String email;

  final String password;

  final bool isRememberMe;

  LoginParams({
    required this.email,
    required this.password,
    required this.isRememberMe,
  }) : super();

  @override
  List<Object?> get props => [];
}