import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repos_impl/number_trivia_repo_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) =>
      super.noSuchMethod(Invocation.method(#getConcreteNumberTrivia, [number]),
          returnValue: Future.delayed(
              Duration(
                milliseconds: 1,
              ),
              () => NumberTriviaModel(number: 1, text: 'Test text')));

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      super.noSuchMethod(Invocation.method(#getRandomNumberTrivia, []),
          returnValue: await null);
}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {
  @override
  Future<NumberTriviaModel> getLastNumberTrivia() =>
      super.noSuchMethod(Invocation.method(#getLastNumberTrivia, []),
          returnValue: Future.delayed(
              Duration(
                milliseconds: 1,
              ),
              () => NumberTriviaModel(number: 1, text: 'Test text')));

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel? triviaModelToCache) => super
      .noSuchMethod(Invocation.method(#cacheNumberTrivia, [triviaModelToCache]),
          returnValue: true);
}

class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> get isConnected =>
      super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future.delayed(Duration(milliseconds: 1), () => true));
}

late NumberTriviaRepoImpl repo;
late MockRemoteDataSource mockRemoteDataSource;
late MockLocalDataSource mockLocalDataSource;
late MockNetworkInfo mockNetworkInfo;

void main() {
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = NumberTriviaRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tNumber = 1;
  final NumberTriviaModel tNumberTriviaModel =
      NumberTriviaModel(text: 'test text', number: tNumber);

  final NumberTrivia tNumberTrivia =
      NumberTrivia(text: 'test text', number: tNumber);

  group('getConcreteNumberTrivia', () {
    test('should check if the device is connected to Internet', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      await repo.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data', () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        //act
        final result = await repo.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        //expect(result, equals(Right<Failure, NumberTrivia>(tNumberTrivia)));
      });
      test('should cache data locally', () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tNumberTriviaModel);
        //act
        await repo.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
    });
  });
}
