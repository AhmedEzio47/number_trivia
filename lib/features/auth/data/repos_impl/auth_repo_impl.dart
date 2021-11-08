import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';
import 'package:number_trivia/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password}) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(ServerFailure());
    }
    try {
      UserEntity user =
          await remoteDataSource.login(email: email, password: password);
      return Right(user);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(
            errorMessage: ex.errorMessage, errorCode: ex.errorCode));
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      {required String email,
      required String password,
      required String name}) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(ServerFailure());
    }
    try {
      UserEntity user = await remoteDataSource.register(
          email: email, password: password, name: name);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUser() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(ServerFailure());
    }
    try {
      UserEntity user = await remoteDataSource.fetchUser();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(ServerFailure());
    }
    try {
      return Right(remoteDataSource.logout());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
