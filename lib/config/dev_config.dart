import 'package:ambientes2/config/base_config.dart';

class DevConfig implements BaseConfig {
  @override
  // TODO: implement baseUrl
  String get baseUrl => "https://com.example.app.dev";

  @override
  // TODO: implement reportErrors
  bool get reportErrors => false;

  @override
  // TODO: implement trackEvents
  bool get trackEvents => false;

}
