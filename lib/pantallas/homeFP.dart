import 'package:fast_park/widget/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HomeFP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: cuerpo(context),
      );
    } else {
      return Scaffold(
        body: cuerpo(context),
      );
    }
  }

  Widget cuerpo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Botones(
          textoBoton: 'Modo usuario',
          tipoBoton: TipoBoton.BotonLogin,
          onPressed: () => Navigator.pushNamed(context, '/usuarioHomeFP'),
        ),
        Botones(
          textoBoton: 'Modo dueño',
          tipoBoton: TipoBoton.BotonLogin,
          onPressed: () => Navigator.pushNamed(context, '/ownerFP'),
        ),
      ],
    );
  }
}
