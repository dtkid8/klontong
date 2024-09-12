// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'SENTRY_URL', obfuscate: true)
  static final String sentryUrl = _Env.sentryUrl;
}
