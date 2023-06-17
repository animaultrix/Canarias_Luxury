import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/models/model_cart.dart';
import 'package:proyecto_dam/models/models.dart';

import 'package:proyecto_dam/theme/app_theme.dart';
//importacion de las rutas
import 'package:proyecto_dam/router/app_routes.dart';
//importacion de multilenguaje
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proyecto_dam/widgeds/usuario_provider.dart';
import 'generated/l10n.dart';
//importacion de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Inicializa el enlace de servicios de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  //inicializar firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //inicializar app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TiendaCartModel>(
          create: (context) => TiendaCartModel(),
        ),
        ChangeNotifierProvider<OcioCartModel>(
          create: (context) => OcioCartModel(),
        ),
      ],
      child: UsuarioProvider(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //envolver en usuario provider para poder acceder desde toda la app
    return UsuarioProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        //onGenerateRoute:(settings) => AppRoutes.onGenerateRoute(settings),
        //se puede simplificar por que settings es el unico argumento que enviamos
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.lightTheme,
        //Flutter IntL Internacionalización
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
      ),
    );
  }
}
