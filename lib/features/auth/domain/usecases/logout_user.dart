import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  LogoutUser({required this.authRepo});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return authRepo.logout();
  }
}
