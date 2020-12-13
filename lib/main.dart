import 'package:fast_park/blocs/autenticacion.dart';
import 'package:fast_park/design/colores.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:fast_park/pantallas/homeFP.dart';
import 'package:fast_park/pantallas/loginFP.dart';
import 'package:fast_park/servicios/rutas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

final autenticacion = Autenticacion();
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => autenticacion),
      FutureProvider(
        create: (context) => autenticacion.isLoggedIn(),
      )
    ], child: Plataformas());
  }

  @override
  void dispose() {
    autenticacion.dispose();
    super.dispose();
  }
}

class Plataformas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'FastPark!',
        home: (isLoggedIn == null)
            ? cargando(false)
            : (isLoggedIn == true)
                ? HomeFP()
                : Login(),
        onGenerateRoute: Rutas.materialRoutes,
        theme: CupertinoThemeData(
          primaryColor: ColoresApp.naranja,
          scaffoldBackgroundColor: Colors.white,
          textTheme: CupertinoTextThemeData(
            tabLabelTextStyle: TextosDes.suggestion,
          ),
          //brightness: Brightness.dark
        ),
      );
    } else {
      return MaterialApp(
          title: 'FastPark!',
          home: (isLoggedIn == null)
              ? cargando(false)
              : (isLoggedIn == true)
                  ? HomeFP()
                  : Login(),
          onGenerateRoute: Rutas.materialRoutes,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white));
    }
  }

  Widget cargando(bool isIOS) {
    return (isIOS)
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
