import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loginapp_demo/core/error/failures.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> execute(Params params);
}

abstract class NoParams extends Equatable{}