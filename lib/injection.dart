import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loginapp_demo/BaseUrls.dart';
import 'package:loginapp_demo/core/data/base_remote_datasource.dart';
import 'package:loginapp_demo/core/network/network_info.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/core/utils/input_validator.dart';
import 'package:loginapp_demo/data/datasources/login_local_data_source.dart';
import 'package:loginapp_demo/data/datasources/login_remote_data_source.dart';
import 'package:loginapp_demo/data/repositories/login_repository_impl.dart';
import 'package:loginapp_demo/domain/repositories/login_repository.dart';
import 'package:loginapp_demo/domain/usecases/login_usecase.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // initInjections(serviceLocator);
  final sharedPrefrences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefrences);
  serviceLocator.registerLazySingleton(
        () {
      final dio = Dio(BaseOptions(
          connectTimeout: 20000,
          baseUrl: Urls.BaseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain));
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
        ),
      );
      return dio;
    },
  );
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());

  //! Core
  serviceLocator.registerLazySingleton(() => InputValidator());
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<BaseRemoteDataSource>(
        () => BaseRemoteDataSourceImpl(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LoginLocalDataSource>(
        () => LoginLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
       serviceLocator(),
       serviceLocator(),
       serviceLocator(),),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => LoginUsecase(repository: serviceLocator()));

  //! Features
  // Bloc
  serviceLocator.registerFactory(
        () => LoginBloc(
      login: serviceLocator(),
      inputValidator: serviceLocator(),
    ),
  );
}