import 'dart:io';

import 'package:fast_park/widget/barra.dart';
import 'package:fast_park/widget/usuario_scaf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool boxScroll) {
            return <Widget>[
              Barra.cupertinoBarra(title: 'FastPark!', context: context),
            ];
          },
          body: UsuarioScaff.cupertinoTabScaffoldUser,
        ),
      );
    } else {
      return Center(
        child: Scaffold(body: Text('bienvenido')),
      );
    }
  }
}
