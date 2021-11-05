import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';

class InputConverter {
  Either<Failure, int> convertStringToUnsignedInt(String input) {
    try {
      int integer = int.parse(input);
      if (integer < 0) {
        throw FormatException();
      }
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
