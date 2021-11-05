import 'dart:convert';

import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const String CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModelToCache) async {
    await sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      jsonEncode(triviaModelToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
