import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usescases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo {
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number) =>
      super.noSuchMethod(Invocation.method(#getConcreteNumberTrivia, [number]),
          returnValue: Future.delayed(
              Duration(
                milliseconds: 1,
              ),
              () => Right<Failure, NumberTrivia>(tNumberTrivia)));
}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepo mockNumberTriviaRepo;
  setUp(() {
    mockNumberTriviaRepo = MockNumberTriviaRepo();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepo);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get number trivia from repository', () async {
    //arrange
    when(mockNumberTriviaRepo.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    //act
    final result = await usecase(Params(number: tNumber));
    //assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepo.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepo);
  });
}
