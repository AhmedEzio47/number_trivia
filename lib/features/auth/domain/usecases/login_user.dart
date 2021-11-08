import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';

class LoginUser implements UseCase<UserEntity, LoginParams> {
  final AuthRepo authRepo;

  LoginUser({required this.authRepo});

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return authRepo.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
