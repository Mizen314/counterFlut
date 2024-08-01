import 'package:ambientes2/ConsentManager.dart';
import 'package:ambientes2/env/environment.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  enviarEvento() {
    FirebaseAnalytics.instance.logEvent(name: 'click', parameters: {
      'click_type': "button",
      'click_detail': "Evento",
      'flow': "prueba"
    });

    // FirebaseAnalytics.instance.setConsent(
    //   adUserDataConsentGranted: false,
    //   analyticsStorageConsentGranted: false,
    //   adPersonalizationSignalsConsentGranted: false,
    //   adStorageConsentGranted: false,
    //   functionalityStorageConsentGranted: false,
    //   personalizationStorageConsentGranted: false,
    //   securityStorageConsentGranted: false,
    // );
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

  activarCollect() {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FirebaseAnalytics.instance.logEvent(name: 'consent', parameters: {
      'click_type': "button",
      'click_detail': "Activar consent",
      'flow': "consentLab"
    });
    print("Consent otorgado");
  }

  desactivarCollect() {
    FirebaseAnalytics.instance.logEvent(name: 'consent', parameters: {
      'click_type': "button",
      'click_detail': "Desactivar consent",
      'flow': "consentLab"
    });
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    print("consent Denegado");
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 100)),
                Dialog.fullscreen(
                    child: Container(
                  color: Colors.green[100],
                  child: Text('Activar Analytics', textScaler: TextScaler.linear(2),),
                ))
              ]),
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
                    onPressed: () => enviarEvento(),
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
                    child: Text('Activar Analytics'),
                  ),
                  ElevatedButton(
                    onPressed: () => activarCollect(),
                    child: const Text('True'),
                  ),
                  ElevatedButton(
                    onPressed: () => desactivarCollect(),
                    child: const Text('False'),
                  ),
                ],
              ),
              
            ]),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _showConsentFlow();
  }

  Future<void> _showConsentFlow() async {
    bool consentGiven = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Consentimiento de Datos"),
          content: Text(
              "Esta aplicación recopila datos para mejorar su experiencia. ¿Acepta el uso de sus datos?"),
          actions: [
            TextButton(
              child: Text("Rechazar"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (consentGiven != null && consentGiven) {
      _proceedWithUserConsent();
    } else {
      _handleConsentDeclined();
    }
  }

  void _proceedWithUserConsent() {
    // Habilitar la recopilación de datos de Firebase Analytics
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    ConsentManager.storeConsentStatus(true);

    print("El usuario ha aceptado el consentimiento.");
  }

  void _handleConsentDeclined() {
    // Deshabilitar la recopilación de datos de Firebase Analytics
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    ConsentManager.storeConsentStatus(false);
    print("El usuario ha rechazado el consentimiento.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Consent Flow Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showConsentFlow,
          child: Text("Mostrar Diálogo de Consentimiento"),
        ),
      ),
    );
  }
}
