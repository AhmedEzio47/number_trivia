import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password});

  Future<Either<Failure, UserEntity>> register(
      {required String email, required String password, required String name});

  Future<Either<Failure, UserEntity>> fetchUser();
  Future<Either<Failure, void>> logout();
}
