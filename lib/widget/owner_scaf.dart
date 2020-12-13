import 'package:fast_park/design/colores.dart';
import 'package:fast_park/pantallas/chatsOwner.dart';
import 'package:fast_park/pantallas/cuentaOwner.dart';
import 'package:fast_park/pantallas/parqueosOwner.dart';
import 'package:fast_park/pantallas/reservasOwner.dart';
import 'package:flutter/cupertino.dart';

abstract class OwnerScaff {
  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
      tabBar: _cupertinoBarra,
      tabBuilder: (context, index) {
        return _eleccion(index);
      },
    );
  }

  static get _cupertinoBarra {
    return CupertinoTabBar(
      backgroundColor: ColoresApp.naranjaClaro,
      items: <BottomNavigationBarItem>[
        // ignore: deprecated_member_use
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location),
            // ignore: deprecated_member_use
            title: Text('Parqueos')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            // ignore: deprecated_member_use
            title: Text('Chats')),
        // ignore: deprecated_member_use
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.car_detailed),
            // ignore: deprecated_member_use
            title: Text('Reservas')),
        // ignore: deprecated_member_use
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            // ignore: deprecated_member_use
            title: Text('Cuenta')),
      ],
    );
  }

  static Widget _eleccion(int index) {
    if (index == 0) {
      return ParqueosOwner();
    }

    if (index == 1) {
      return ChatsOwner();
    }

    if (index == 2) {
      return ReservasOwner();
    }

    if (index == 3) {
      return CuentaOwner();
    }
  }
}
