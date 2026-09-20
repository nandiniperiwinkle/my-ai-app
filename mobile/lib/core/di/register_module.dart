import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../network/dio_client.dart';

/// Registers third-party types that injectable can't construct itself
/// (no constructor annotations to scan) — e.g. an already-configured
/// [Dio] instance or a plugin class like [Connectivity]. Without this,
/// anything depending on these types (see `NetworkInfoImpl`) would
/// compile but fail at runtime with "type X is not registered".
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioClient.create();

  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
