import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///Gets latest cached number trivia model
  ///
  /// Throws a [CacheException] when no cached trivia exists
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///Caches given trivia model
  ///
  /// Throws a [CacheException] when
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModelToCache);
}
