import 'package:fast_park/design/colores.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Barra {
  static CupertinoSliverNavigationBar cupertinoBarra(
      {String title, BuildContext context}) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title),
      backgroundColor: Colors.transparent,
      //border: null,
    );
  }

  static SliverAppBar androidBarra(
      {@required String title, @required TabBar tabBar}) {
    return SliverAppBar(
      title: Text(
        title,
        style: TextosDes.titulo,
      ),
      backgroundColor: ColoresApp.naranjaClaro,
      bottom: tabBar,
      floating: true,
      pinned: true,
      snap: true,
    );
  }
}
