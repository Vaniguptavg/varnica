import 'package:dio/dio.dart';
import 'package:loginapp_demo/core/data/base_remote_datasource.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/data/models/user_model.dart';

abstract class LoginRemoteDataSource extends BaseRemoteDataSource {
  Future<UserModel> loginUser(String email, String password);
}

class LoginRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl({required this.dio}) : super(dio: dio);

  @override
  Future<UserModel> loginUser(
      String email, String password) async {
    return await performPostRequest<UserModel>(
      Endpoints.LOGIN,
      RequestBody.login(email: email, password: password),
      FullTypes.LOGIN,
      options: OPTION,
    );
  }
}
