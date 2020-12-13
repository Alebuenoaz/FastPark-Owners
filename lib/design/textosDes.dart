import 'package:fast_park/design/colores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextosDes {
  static TextStyle get cuerpo {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: ColoresApp.grisoscuro, fontSize: 16.0));
  }

  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: ColoresApp.grisclaro, fontSize: 14.0));
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold));
  }

  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: ColoresApp.amarillo,
            fontSize: 15.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get error {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: ColoresApp.rojo, fontSize: 14.0));
  }

  static TextStyle get titulo {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
  }
}
