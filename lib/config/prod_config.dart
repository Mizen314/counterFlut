import 'package:ambientes2/config/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  // TODO: implement baseUrl
  String get baseUrl => "https://com.example.app";

  @override
  // TODO: implement reportErrors
  bool get reportErrors => true;

  @override
  // TODO: implement trackEvents
  bool get trackEvents => true;
  
}
