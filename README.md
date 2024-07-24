# App de Ambientes con separación x dimension

Este laboratorio tiene la particularidad que se utilizó para probar la separacion de ambientes, pero se le agregó la funcionalidad de poder identificar los pantallas a través del método logScreenView.

Adjunto ejemplo.

cambiarPantalla() {
      FirebaseAnalytics.instance.logScreenView(
          screenClass: 'PantallaPrincipalButton',
          screenName: 'PantallaPrincipalFromButton');
    }

## Iniciando el proyecto

Lo interesante que tiene esta aplicación es que permite ver como los eventos que se disparan en una pantalla que ha uutilizado el logscreenview, automáticamente se alinean a esa pantalla, HASTA QUE, se designe otra pantalla.

Especificacion teórica
Google Analytics hace un seguimiento de las transiciones de pantalla y adjunta información sobre la pantalla actual a los eventos, lo que te permite hacer un seguimiento de métricas como la participación de los usuarios o su comportamiento por pantalla. 

Gran parte de esta recopilación de datos ocurre automáticamente, aunque también se puede registrar las vistas de pantalla de forma manual.

1. Inhabilitar el seguimiento automático de vista de pantalla. :no_entry_sign: 
:android: En Android, se debe anidar el siguiente parámetro de configuración en la etiqueta <application> del archivo AndroidManifest.xml:



<meta-data 
    android:name="google_analytics_automatic_screen_reporting_enabled" 
    android:value="false" 
/>

:iOS: En iOS, los informes automáticos de vista de pantalla se pueden desactivar configurando FirebaseAutomaticScreenReportingEnabled como NO (booleano) en Info.plist.

2. Realizar la implementación del seguimiento manual de pantallas. :a: 
En cuestión a realizar este seguimiento de forma manual, hay diferentes formas y métodos para implementarlo. Algunos de estos métodos, van a comenzar a quedar deprecados y hoy en día Google recomienda que utilicemos logEvent.

De igual forma, vamos a dejar estos methods disponibles en la documentación, para que puedan utilizar el que mejor se adapte a su aplicación: 


Usando el evento ‘screen_view’ para registrar una vista de pantalla con los métodos onAppear, viewDidAppear para IOS y onResume para Android.



@Override
    protected void onResume() {
        super.onResume();
        await FirebaseAnalytics.instance.logEvent(
          name: 'screen_view',
          parameters: {
            'screen_name': screenName,
            'screen_class': screenClass,
          },
      ); 
  },
Usando el método setCurrentScreen:



FirebaseAnalytics().setCurrentScreen(
    screenName: 'PantallaPrincipal',
    screenClassOverride: 'MiPantallaPrincipal');
El método setCurrentScreen acepta dos parámetros:

screenName: El nombre de la pantalla actual.

screenClassOverride: El nombre de la clase de la pantalla actual. Esto puede ser útil si el nombre de la clase no coincide con el nombre de la pantalla.

 

Es importante aclarar que estas son dos formas de implementar el seguimiento de pantallas que hemos logrado probar. También se puede crear un método propio para el seguimiento de pantallas. Esto puede ser útil si necesitan funcionalidades específicas que no están disponibles en los paquetes existentes o porque tienen particularidades en sus proyectos que deben adaptar a los métodos según sus necesidades. 

Taxonomía del Nombre y Clase de Pantalla
A la hora de organizar los nombres de pantalla (firebase_screen) y clase de pantalla (firebase_screen_class), hemos establecido una jerarquía para mantener un orden en común entre los diferentes activos del banco y sus flujos. 

De esta forma, nos permite comprender mejor la actividad de los usuarios entre diferentes pantallas, siendo beneficioso para su explotación en Google Analytics 4 y mantenemos una organización de trabajo al momento de elaborar los requerimientos de tagging.  

A modo de ejemplo, hemos elaborado una nomenclatura con niveles que permiten una mayor descripción en la representación de funcionalidad en cada pantalla. 

 

Niveles Ejemplos Concepto

Nivel 1: Categoría principal 

p.ej. "Seguros", "Cuentas", "Pagos".  Se busca determinar el activo principal. 

Nivel 2: Subcategoría 

p.ej. "Seguros_Inicio", "Cuentas_Resumen", "Pagos_Transferencias". Se puede agregar mayor contexto, como la parte del flujo en el que se encontraría el usuario. 

Nivel 3: Pantalla específica 

p.ej. "Seguros_Inicio - Tenencias", "Cuentas_Resumen - Saldo", "Pagos_Transferencias - Confirmar". Puntualizar en la pantalla específica, aquí se debe ser lo más claro posible de la acción en la que se encuentra el usuario. 

Lo que respecta a Clase de pantalla, se puede utilizar el mismo nombre del activo o lo definido en el Nivel 1. 

