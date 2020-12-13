import 'package:fast_park/design/textosDes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Alertas {
  static Future<void> mostrarError(
      bool isIOS, BuildContext context, String error) async {
    return (isIOS)
        ? showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  'Error',
                  style: TextosDes.error,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        error,
                        style: TextosDes.cuerpo,
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'Ok',
                      style: TextosDes.cuerpo,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Error',
                  style: TextosDes.error,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        error,
                        style: TextosDes.cuerpo,
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Ok',
                      style: TextosDes.cuerpo,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            });
  }
}
