import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repos_impl/number_trivia_repo_impl.dart';

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
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      super.noSuchMethod(Invocation.method(#getRandomNumberTrivia, []),
          returnValue: Future.delayed(
              Duration(
                milliseconds: 1,
              ),
              () => NumberTriviaModel(number: 1, text: 'Test text')));
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
  Future<void> cacheNumberTrivia(NumberTriviaModel? triviaModelToCache) =>
      super.noSuchMethod(
          Invocation.method(#getLastNumberTrivia, [triviaModelToCache]),
          returnValue: Future.delayed(
              Duration(
                milliseconds: 1,
              ),
              () {}));
}

class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> get isConnected =>
      super.noSuchMethod(Invocation.getter(#uri), returnValue: () => true);
}

void main() {
  NumberTriviaRepoImpl repo;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
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
  test('', () {});
}
