import 'package:ambientes2/config/base_config.dart';

class Staging implements BaseConfig {
  @override
  // TODO: implement baseUrl
  String get baseUrl => "https://staging.myapp.com";

  @override
  // TODO: implement reportErrors
  bool get reportErrors => true;

  @override
  // TODO: implement trackEvents
  bool get trackEvents => true;
  
}
