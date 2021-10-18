import 'package:dartz/dartz.dart';
import 'package:loginapp_demo/core/data/base_repository.dart';
import 'package:loginapp_demo/core/error/failures.dart';
import 'package:loginapp_demo/domain/entities/User.dart';

abstract class LoginRepository extends BaseRepository {
  Future<Either<Failure, User>> loginUser(
    String email,
    String password,
    bool isRememberMe,
  );
}
