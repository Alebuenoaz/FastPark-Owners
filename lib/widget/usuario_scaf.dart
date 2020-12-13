import 'package:fast_park/design/colores.dart';
import 'package:fast_park/pantallas/chatUsuario.dart';
import 'package:fast_park/pantallas/cuentaUsuario.dart';
import 'package:fast_park/pantallas/parqueosUsuario.dart';
import 'package:flutter/cupertino.dart';

abstract class UsuarioScaff {
  static CupertinoTabScaffold get cupertinoTabScaffoldUser {
    return CupertinoTabScaffold(
      tabBar: _cupertinoBarraUser,
      tabBuilder: (context, index) {
        return _eleccion(index);
      },
    );
  }

  static get _cupertinoBarraUser {
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
            icon: Icon(CupertinoIcons.person),
            // ignore: deprecated_member_use
            title: Text('Cuenta')),
      ],
    );
  }

  static Widget _eleccion(int index) {
    if (index == 0) {
      return ParqueosUsuario();
    }

    if (index == 1) {
      return ChatsUsuario();
    }

    if (index == 2) {
      return CuentaUsuario();
    }
  }
}
