import 'package:fast_park/design/base.dart';
import 'package:fast_park/design/colores.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:flutter/material.dart';

abstract class TextosCampos {
  static double textBoxHorizonatal() {
    return 25.0;
  }

  static double textBoxVertical() {
    return 8.0;
  }

  static TextStyle text() {
    return TextosDes.cuerpo;
  }

  static TextStyle placeholder() {
    return TextosDes.suggestion;
  }

  static Color colorCursor() {
    return ColoresApp.naranja;
  }

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        icon,
        size: 35.0,
        color: ColoresApp.naranja,
      ),
    );
  }

  static BoxDecoration get cupertino {
    return BoxDecoration(
        border: Border.all(
          color: ColoresApp.naranja,
          width: EstilosBase.borderWidth,
        ),
        borderRadius: BorderRadius.circular(EstilosBase.borderRadius));
  }

  static TextAlign textAlign() {
    return TextAlign.center;
  }

  static BoxDecoration get cupertinoError {
    return BoxDecoration(
        border: Border.all(
          color: ColoresApp.rojo,
          width: EstilosBase.borderWidth,
        ),
        borderRadius: BorderRadius.circular(EstilosBase.borderRadius));
  }

  static BoxDecoration get cupertinoErrorDes {
    return BoxDecoration(
        border: Border.all(
          color: ColoresApp.rojo,
          width: EstilosBase.borderWidth,
        ),
        borderRadius: BorderRadius.circular(EstilosBase.borderRadius));
  }

  static InputDecoration androidIcons(
      String hintText, IconData icon, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextosCampos.placeholder(),
      border: InputBorder.none,
      errorText: errorText,
      errorStyle: TextosDes.error,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColoresApp.naranja, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColoresApp.naranja, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColoresApp.naranja, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColoresApp.rojo, width: EstilosBase.borderWidth),
          borderRadius: BorderRadius.circular(EstilosBase.borderRadius)),
      prefixIcon: iconPrefix(icon),
    );
  }
}
