import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';

class FetchUser implements UseCase<UserEntity, NoParams> {
  AuthRepo authRepo;
  FetchUser({required this.authRepo});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return authRepo.fetchUser();
  }
}
