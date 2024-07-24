import 'package:ambientes2/app.dart';
import 'package:ambientes2/env/environment.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  String environment = const String.fromEnvironment('environment',
      defaultValue: Environment.prod);
  Environment().initConfig(environment);
  
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    FirebaseAnalytics.instance.logScreenView(
    screenClass: 'PantallaPrincipal',
    screenName: 'PantallaPrincipalName'
      );
  
    await FirebaseAnalytics.instance.setUserId(id: "123456");

}
