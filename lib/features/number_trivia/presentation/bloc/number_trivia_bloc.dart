import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/input_converters.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concreteUseCase;
  final GetRandomNumberTrivia randomUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.concreteUseCase,
      required this.randomUseCase,
      required this.inputConverter})
      : super(EmptyNumberTrivia()) {}

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumberEvent) {
      final failureOrInput =
          inputConverter.convertStringToUnsignedInt(event.numberString);

      yield* failureOrInput.fold((formatFailure) async* {
        yield ErrorNumberTriviaState(
            errorMessage: mapFailureToMessage(formatFailure));
      }, (input) async* {
        yield LoadingNumberTriviaState();
        final failureOrTrivia = await concreteUseCase(Params(number: input));
        yield* _readyOrErrorState(failureOrTrivia);
      });
    } else if (event is GetTriviaForRandomNumberEvent) {
      yield LoadingNumberTriviaState();
      final failureOrTrivia = await randomUseCase(NoParams());
      yield* _readyOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _readyOrErrorState(
      Either<Failure, NumberTrivia> failureOrTrivia) async* {
    yield failureOrTrivia.fold(
        (failure) =>
            ErrorNumberTriviaState(errorMessage: mapFailureToMessage(failure)),
        (trivia) => ReadyNumberTriviaState(trivia: trivia));
  }
}
