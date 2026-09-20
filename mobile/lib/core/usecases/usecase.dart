import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

/// Base contract every domain usecase implements.
///
/// [Type] is the successful return value, [Params] is the input the
/// presentation layer passes in. Usecases never throw — failures are
/// values, carried on the `Left` side of the [Either].
abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use for usecases that take no arguments (e.g. `GetCurrentUser`).
final class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
