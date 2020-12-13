import 'package:fast_park/design/base.dart';
import 'package:fast_park/design/botonesDes.dart';
import 'package:fast_park/design/colores.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Botones extends StatefulWidget {
  final String textoBoton;
  final TipoBoton tipoBoton;
  final void Function() onPressed;

  Botones({
    @required this.textoBoton,
    this.tipoBoton,
    this.onPressed,
  });

  @override
  _BotonesState createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  bool presionado = false;

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    // ignore: unused_local_variable
    Color colorBoton;

    switch (widget.tipoBoton) {
      case TipoBoton.BotonLogin:
        fontStyle = TextosDes.buttonTextLight;
        colorBoton = ColoresApp.naranja;
        break;

      case TipoBoton.Deshabilitado:
        fontStyle = TextosDes.buttonTextLight;
        colorBoton = ColoresApp.naranjaClaro;
        break;

      default:
        fontStyle = TextosDes.buttonTextLight;
        colorBoton = ColoresApp.naranjaClaro;

        break;
    }
    return AnimatedContainer(
      padding: EdgeInsets.only(
        top: (presionado)
            ? EstilosBase.listaVertical + EstilosBase.animacion
            : EstilosBase.listaVertical,
        bottom: (presionado)
            ? EstilosBase.listaVertical - EstilosBase.animacion
            : EstilosBase.listaVertical,
        left: EstilosBase.listaHorizontal,
        right: EstilosBase.listaHorizontal,
      ),
      child: GestureDetector(
        child: Container(
          height: EstiloBotones.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: colorBoton,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              widget.textoBoton,
              style: fontStyle,
            ),
          ),
        ),
        onTapDown: (details) {
          setState(() {
            if (widget.tipoBoton != TipoBoton.Deshabilitado)
              presionado = !presionado;
          });
        },
        onTapUp: (details) {
          setState(
            () {
              if (widget.tipoBoton != TipoBoton.Deshabilitado)
                presionado = !presionado;
            },
          );
        },
        onTap: () {
          if (widget.tipoBoton != TipoBoton.Deshabilitado) {
            widget.onPressed();
          }
        },
      ),
      duration: Duration(milliseconds: 100),
    );
  }
}

enum TipoBoton { BotonLogin, Deshabilitado }
