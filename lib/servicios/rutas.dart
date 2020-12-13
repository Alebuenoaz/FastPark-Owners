//Esta clase es mas limitada que una clase normal
//pero nos permite llamar a assets directamente
//sin iniciar la clase desde otro widget

import 'package:fast_park/pantallas/homeFP.dart';
import 'package:fast_park/pantallas/crearFP.dart';
import 'package:fast_park/pantallas/loginFP.dart';
import 'package:fast_park/pantallas/owner.dart';
import 'package:fast_park/pantallas/parqueosOwner.dart';
import 'package:fast_park/pantallas/usuarioHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Rutas {
  //Rutas para android
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/homeFP":
        return MaterialPageRoute(builder: (context) => HomeFP());

      case "/crearFP":
        return MaterialPageRoute(builder: (context) => CrearCuenta());

      case "/loginFP":
        return MaterialPageRoute(builder: (context) => Login());

      case "/ownerFP":
        return MaterialPageRoute(builder: (context) => Owner());

      case "/parqueosFP":
        return MaterialPageRoute(builder: (context) => ParqueosOwner());

      case "/usuarioHomeFP":
        return MaterialPageRoute(builder: (context) => HomeUsuario());

      default:
        return MaterialPageRoute(builder: (context) => Login());
    }
  }

  //Rutas para iOS
  static CupertinoPageRoute cupertinoRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/homeFP":
        return CupertinoPageRoute(builder: (context) => HomeFP());

      case "/crearFP":
        return CupertinoPageRoute(builder: (context) => CrearCuenta());

      case "/loginFP":
        return CupertinoPageRoute(builder: (context) => Login());

      case "/ownerFP":
        return CupertinoPageRoute(builder: (context) => Owner());

      case "/parqueosFP":
        return CupertinoPageRoute(builder: (context) => ParqueosOwner());

      case "/usuarioHomeFP":
        return CupertinoPageRoute(builder: (context) => HomeUsuario());

      default:
        return CupertinoPageRoute(builder: (context) => Login());
    }
  }
}
