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

  // Inicialización de firebase
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Log de screen view inicial - forma sencilla, para realizarla despues
  //que se inicializa la pantalla principal
  FirebaseAnalytics.instance.logScreenView(
      screenClass: 'PantallaPrincipal', screenName: 'PantallaPrincipalName');

  //user ID
  await FirebaseAnalytics.instance.setUserId(id: "123456");

  //Colection off por defecto
  //FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);

  //widget


}
