import 'package:dartz/dartz.dart';
import 'package:loginapp_demo/core/data/base_repository.dart';
import 'package:loginapp_demo/core/error/exceptions.dart';
import 'package:loginapp_demo/core/error/failures.dart';
import 'package:loginapp_demo/core/network/network_info.dart';
import 'package:loginapp_demo/data/datasources/login_local_data_source.dart';
import 'package:loginapp_demo/data/datasources/login_remote_data_source.dart';
import 'package:loginapp_demo/domain/entities/User.dart';
import 'package:loginapp_demo/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends BaseRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;
  final NetworkInfo networkInfo;


  LoginRepositoryImpl(
      this.loginRemoteDataSource, this.loginLocalDataSource, this.networkInfo)
      : super(networkInfo: networkInfo);

  @override
  Future<Either<Failure, User>> loginUser(
      String email, String password,
      bool isRememberMe) async {
    return await checkNetwork<User>(
          () async {
        try {
          final userModel = await loginRemoteDataSource.loginUser(email, password);
          if (userModel != null) {
            await loginLocalDataSource.updateUser(userModel, isRememberMe);
            return Right(userModel);
          }
          return Left(ServerFailure());
        } on ServerException catch (e) {
          print('e is $e');
          return Left(ServerFailure());
        }
      },
    );
  }

}