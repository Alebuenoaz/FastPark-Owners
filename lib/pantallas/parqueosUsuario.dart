import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

class ParqueosUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: cuerpo(),
      );
    } else {
      return Scaffold(
        body: cuerpo(),
      );
    }
  }

  Widget cuerpo() {
    return Center(
      child: Text('Parqueos'),
    );
  }
}
