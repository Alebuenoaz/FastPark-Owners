import 'package:flutter/cupertino.dart';

abstract class EstilosBase {
  static double get borderRadius {
    return 30.0;
  }

  static double get borderWidth {
    return 2.0;
  }

  static double get listaHorizontal {
    return 30.0;
  }

  static double get listaVertical {
    return 8.0;
  }

  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(
        horizontal: listaHorizontal, vertical: listaVertical);
  }

  static double get animacion {
    return 3.0;
  }
}
