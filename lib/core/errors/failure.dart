import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/custom_error_messages.dart';

const String SERVER_ERROR_MESSAGE = 'Server failure';
const String CACHE_ERROR_MESSAGE = 'Cache failure';
const String INVALID_INPUT_ERROR_MESSAGE = 'Invalid input';
const String UNKNOWN_ERROR = 'Unknown error';

abstract class Failure extends Equatable {
  Failure({List properties = const <dynamic>[]});

  @override
  List<Object> get props => [];
}

//General failures
class ServerFailure extends Failure {
  String? errorCode;
  String? errorMessage;
  ServerFailure({this.errorCode, this.errorMessage});
}

class CacheFailure extends Failure {}

class InvalidInputFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      print((failure as ServerFailure).errorCode);
      return CustomErrorMessages
              .errorMessages[(failure as ServerFailure).errorCode] ??
          SERVER_ERROR_MESSAGE;
    case CacheFailure:
      return CACHE_ERROR_MESSAGE;
    case InvalidInputFailure:
      return INVALID_INPUT_ERROR_MESSAGE;
    default:
      return UNKNOWN_ERROR;
  }
}
