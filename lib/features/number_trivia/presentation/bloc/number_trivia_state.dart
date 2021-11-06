part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class EmptyNumberTrivia extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadingNumberTriviaState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class ReadyNumberTriviaState extends NumberTriviaState {
  final NumberTrivia trivia;
  ReadyNumberTriviaState({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class ErrorNumberTriviaState extends NumberTriviaState {
  final String errorMessage;
  ErrorNumberTriviaState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
