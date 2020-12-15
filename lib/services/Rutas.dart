import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebaflutter/screens/parkingRegister.dart';

abstract class Rutas {
  //Rutas para android
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/homeFP":
        return MaterialPageRoute(builder: (context) => ParkingRegister());
    }
  }
}
