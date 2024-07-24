import 'package:ambientes2/config/base_config.dart';
import 'package:ambientes2/config/dev_config.dart';
import 'package:ambientes2/config/prod_config.dart';
import 'package:ambientes2/config/staging_config.dart';

class Environment {
  static final Environment _singleton = Environment._internal();

  factory Environment() => _singleton;

  Environment._internal();

  static const String dev = "DEV";

  static const String staging = "STAGING";

  static const String prod = "PROD";

  BaseConfig? config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.staging:
        return Staging();
      case Environment.prod:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
