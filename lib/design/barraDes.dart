import 'dart:ui';
import 'package:fast_park/design/colores.dart';

abstract class BarraDes {
  static Color get unselectedLabelColor {
    return ColoresApp.grisclaro;
  }

  static Color get selectedLabelColor {
    return ColoresApp.naranja;
  }

  static Color get indicator {
    return ColoresApp.naranja;
  }
}
