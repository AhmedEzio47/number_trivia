class ServerException implements Exception {
  String? errorCode;
  String? errorMessage;
  ServerException({this.errorCode, this.errorMessage});
}

class CacheException implements Exception {}
