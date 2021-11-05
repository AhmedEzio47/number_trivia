import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/utils/input_converters.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_ERROR_MESSAGE = 'Server failure';
const String CACHE_ERROR_MESSAGE = 'Cache failure';
const String INVALID_INPUT_ERROR_MESSAGE = 'Invalid input';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concrete;
  final GetRandomNumberTrivia random;
  final InputConverter inputConverter;
  NumberTriviaBloc(
      {required this.concrete,
      required this.random,
      required this.inputConverter})
      : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) async* {
      if (event is GetTriviaForConcreteNumberEvent) {
        final inputEither =
            inputConverter.convertStringToUnsignedInt(event.numberString);
        yield* inputEither.fold((failure) async* {
          yield ErrorNumberTriviaState(error: INVALID_INPUT_ERROR_MESSAGE);
        }, (input) async* {
          throw UnimplementedError();
        });
      } else if (event is GetTriviaForRandomNumberEvent) {}
    });
  }
}
