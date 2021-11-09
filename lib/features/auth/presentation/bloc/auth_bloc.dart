import 'package:bloc/bloc.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';
import 'package:number_trivia/features/auth/domain/usecases/fetch_user.dart';
import 'package:number_trivia/features/auth/domain/usecases/login_user.dart';
import 'package:number_trivia/features/auth/domain/usecases/logout_user.dart';
import 'package:number_trivia/features/auth/domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUseCase;
  final RegisterUser registerUseCase;
  final FetchUser fetchUseCase;
  final LogoutUser logoutUseCase;
  AuthBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.fetchUseCase,
      required this.logoutUseCase})
      : super(EmptyAuthState()) {}

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingAuthState();
      final failureOrUser = await loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      yield failureOrUser.fold(
          (failure) =>
              ErrorAuthState(errorMessage: mapFailureToMessage(failure)),
          (user) => ReadyAuthState(user: user));
    } else if (event is RegisterEvent) {
      yield LoadingAuthState();
      final failureOrUser = await registerUseCase(
        RegisterParams(
            email: event.email, password: event.password, name: event.name),
      );
      yield failureOrUser.fold(
          (failure) =>
              ErrorAuthState(errorMessage: mapFailureToMessage(failure)),
          (user) => ReadyAuthState(user: user));
    } else if (event is FetchUserEvent) {
      yield LoadingAuthState();
      final failureOrUser = await fetchUseCase(
        NoParams(),
      );
      yield failureOrUser.fold(
          (failure) =>
              ErrorAuthState(errorMessage: mapFailureToMessage(failure)),
          (user) => ReadyAuthState(user: user));
    } else if (event is LogoutUserEvent) {
      yield LoadingAuthState();
      final failureOrUser = await logoutUseCase(
        NoParams(),
      );
      yield failureOrUser.fold(
          (failure) =>
              ErrorAuthState(errorMessage: mapFailureToMessage(failure)),
          (user) => EmptyAuthState());
    } else if (event is ResetStateEvent) {
      yield EmptyAuthState();
    }
  }
}
