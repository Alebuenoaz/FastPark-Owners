import 'package:fast_park/design/base.dart';
import 'package:fast_park/design/botonesDes.dart';
import 'package:fast_park/design/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class BotonesRedes extends StatelessWidget {
  final String textoRedes;
  final TipoRedes tipoRedes;
  final VoidCallback onPressed;

  BotonesRedes(
      {@required this.textoRedes, @required this.tipoRedes, this.onPressed});

  Color iconoColor;
  Color colorBoton;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    switch (tipoRedes) {
      case TipoRedes.Facebook:
        iconoColor = Colors.white;
        colorBoton = ColoresApp.azulFacebook;
        icon = FontAwesomeIcons.facebookF;
        break;
      case TipoRedes.Google:
        iconoColor = Colors.white;
        colorBoton = ColoresApp.azulGoogle;
        icon = FontAwesomeIcons.google;
        break;

      default:
        iconoColor = Colors.white;
        colorBoton = ColoresApp.azulGoogle;
        icon = FontAwesomeIcons.google;

        break;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: EstiloBotones.buttonHeight,
        width: EstiloBotones.buttonHeight,
        decoration: BoxDecoration(
          color: colorBoton,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: iconoColor),
      ),
    );
  }
}

enum TipoRedes { Facebook, Google }
