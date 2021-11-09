import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/injector_container.dart' as dependency_injector;

import 'features/auth/domain/usecases/fetch_user.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
          loginUseCase: dependency_injector.serviceLocator<LoginUser>(),
          registerUseCase: dependency_injector.serviceLocator<RegisterUser>(),
          fetchUseCase: dependency_injector.serviceLocator<FetchUser>(),
          logoutUseCase: dependency_injector.serviceLocator<LogoutUser>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Number Trivia',
        theme: ThemeData(
          accentColor: Colors.green.shade600,
          primaryColor: Colors.green.shade800,
          primarySwatch: Colors.green,
        ),
        home: NumberTriviaPage(),
      ),
    );
  }
}
