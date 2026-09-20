/// Low-level errors thrown by the data layer (datasources).
///
/// Repository implementations catch these and map them to a [Failure]
/// before returning `Either<Failure, T>` to the domain layer.
class ServerException implements Exception {
  const ServerException([this.message = 'Server error occurred.']);
  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache error occurred.']);
  final String message;
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection.']);
  final String message;
}

class UnauthorizedException implements Exception {
  const UnauthorizedException([this.message = 'Unauthorized.']);
  final String message;
}
