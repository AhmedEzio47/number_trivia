import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';

class RegisterUser implements UseCase<UserEntity, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUser({required this.authRepo});

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return authRepo.register(
        email: params.email, password: params.password, name: params.name);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;

  RegisterParams(
      {required this.email, required this.password, required this.name});

  @override
  List<Object?> get props => [email, password, name];
}
