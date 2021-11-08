import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/core/utils/input_converters.dart';
import 'package:number_trivia/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:number_trivia/features/auth/data/repos_impl/auth_repo_impl.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';
import 'package:number_trivia/features/auth/domain/usecases/fetch_user.dart';
import 'package:number_trivia/features/auth/domain/usecases/login_user.dart';
import 'package:number_trivia/features/auth/domain/usecases/logout_user.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repos_impl/number_trivia_repo_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/domain/usecases/register_user.dart';
import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/domain/usescases/get_random_number_trivia.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  ///Features
  initNumberTriviaFeature();
  initAuthFeature();

  ///Core
  serviceLocator.registerLazySingleton(
    () => InputConverter(),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      serviceLocator(),
    ),
  );

  ///External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
}

void initNumberTriviaFeature() {
  ///BLoC
  serviceLocator.registerFactory(
    () => NumberTriviaBloc(
      concreteUseCase: serviceLocator(),
      randomUseCase: serviceLocator(),
      inputConverter: serviceLocator(),
    ),
  );

  ///Use cases
  serviceLocator.registerLazySingleton(
    () => GetConcreteNumberTrivia(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetRandomNumberTrivia(
      serviceLocator(),
    ),
  );

  ///Repositories
  serviceLocator.registerLazySingleton<NumberTriviaRepo>(
    () => NumberTriviaRepoImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
        networkInfo: serviceLocator()),
  );

  ///Data sources
  ///Remote data source
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  ///Local data source
  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );
}

void initAuthFeature() {
  ///BLoC
  serviceLocator.registerFactory(
    () => AuthBloc(
        loginUseCase: serviceLocator(),
        registerUseCase: serviceLocator(),
        fetchUseCase: serviceLocator(),
        logoutUseCase: serviceLocator()),
  );

  ///Use cases
  serviceLocator.registerLazySingleton(
    () => LoginUser(
      authRepo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => RegisterUser(
      authRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => FetchUser(
      authRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LogoutUser(
      authRepo: serviceLocator(),
    ),
  );

  ///Repositories
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
        remoteDataSource: serviceLocator(), networkInfo: serviceLocator()),
  );

  ///Data sources
  ///Remote data source
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: serviceLocator(),
    ),
  );

  ///Local data source
}
