import 'package:equatable/equatable.dart';

/// Base type for all recoverable errors surfaced to the presentation layer.
///
/// Repositories translate low-level [Exception]s (see `exceptions.dart`)
/// into one of these before returning `Either<Failure, T>` from a usecase,
/// so Blocs/Cubits never depend on data-layer error types directly.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on our server.']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Unable to read local data.']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Session expired. Please sign in again.',
  ]);
}
