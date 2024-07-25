import 'package:ambientes2/env/environment.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  showAlertDialog() {
    FirebaseAnalytics.instance.logEvent(name: 'click', parameters: {
      'click_type': "button",
      'click_detail': "asd",
      'flow': "prueba"
    });
  }

  cambiarPantalla() {
    FirebaseAnalytics.instance.logScreenView(
        screenClass: 'PantallaPrincipalButton',
        screenName: 'PantallaPrincipalFromButton');
  }

  volverPantallaInicial() {
    FirebaseAnalytics.instance.logScreenView(
        screenClass: 'PantallaPrincipal', screenName: 'PantallaPrincipalName');
  }

  activarDesactivarCollect() {
    const option = false;
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!option);
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = Environment().config?.baseUrl ?? 'No environment';

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: SafeArea(
            child: Column(children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center horizontally
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(16.0), // Add padding around button
                    child: Text(baseUrl),
                  ),
                  ElevatedButton(
                    onPressed: () => showAlertDialog(),
                    child: const Text('Enviar evento'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center horizontally
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0), // Add padding around button
                    child: Text("Activar 2da pantalla"),
                  ),
                  ElevatedButton(
                    onPressed: () => cambiarPantalla(),
                    child: const Text('Enviar evento'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center horizontally
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0), // Add padding around button
                    child: Text("Activar 1era pantalla"),
                  ),
                  ElevatedButton(
                    onPressed: () => volverPantallaInicial(),
                    child: const Text('Volver pantalla principal'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center horizontally
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0), // Add padding around button
                    child: Text('Activar/desactivar Analytics'),
                  ),
                  ElevatedButton(
                    onPressed: () => activarDesactivarCollect(),
                    child: const Text('True/False'),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
