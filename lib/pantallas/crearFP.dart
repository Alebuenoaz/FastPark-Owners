import 'dart:async';
import 'dart:io';
import 'package:fast_park/blocs/autenticacion.dart';
import 'package:fast_park/design/base.dart';
import 'package:fast_park/design/colores.dart';
import 'package:fast_park/design/textoCampos.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:fast_park/widget/alertas.dart';
import 'package:fast_park/widget/botonesredes.dart';
import 'package:fast_park/widget/buttons.dart';
import 'package:fast_park/widget/correoPass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearCuenta extends StatefulWidget {
  StreamSubscription _userSub;
  StreamSubscription _errorSub;
  @override
  _CrearCuentaState createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  @override
  void initState() {
    final autenticacion = Provider.of<Autenticacion>(context, listen: false);
    widget._userSub = autenticacion.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/homeFP');
    });

    widget._errorSub = autenticacion.errorMessage.listen((error) {
      if (error != '') {
        Alertas.mostrarError(Platform.isIOS, context, error)
            .then((_) => autenticacion.limpiarError);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    widget._userSub.cancel();
    widget._errorSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final autenticacion = Provider.of<Autenticacion>(context);

    if (Platform.isIOS) {
      return CupertinoPageScaffold(child: cuerpo(context, autenticacion));
    } else {
      return Scaffold(
        body: cuerpo(context, autenticacion),
      );
    }
  }

  Widget cuerpo(BuildContext context, Autenticacion autenticacion) {
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('imagenes/logo.png'), fit: BoxFit.fill)),
        ),
        //
        SizedBox(height: 75.0),
        //
        StreamBuilder<String>(
            stream: autenticacion.email,
            builder: (context, snapshot) {
              // ignore: missing_required_param
              return CorreoPass(
                  hintText: 'Correo',
                  isIOS: Platform.isIOS,
                  texto: TextInputType.emailAddress,
                  obscureText: false,
                  onChanged: autenticacion.changeEmail,
                  errorText: snapshot.error);
            }),
        //
        SizedBox(height: 10.0),
        //
        StreamBuilder<String>(
            stream: autenticacion.password,
            builder: (context, snapshot) {
              // ignore: missing_required_param
              return CorreoPass(
                  hintText: 'Contraseña',
                  isIOS: Platform.isIOS,
                  texto: TextInputType.text,
                  obscureText: true,
                  onChanged: autenticacion.changePassword,
                  errorText: snapshot.error);
            }),
        //
        SizedBox(height: 75.0),
        //
        StreamBuilder<bool>(
            stream: autenticacion.isValid,
            builder: (context, snapshot) {
              return Botones(
                textoBoton: 'Registrate',
                tipoBoton: (snapshot.data == true)
                    ? TipoBoton.BotonLogin
                    : TipoBoton.Deshabilitado,
                onPressed: autenticacion.signupEmail,
              );
            }),
        //
        SizedBox(height: 5.0),
        //
        Padding(
          padding: EstilosBase.listPadding,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '¿Ya tienes una cuenta? ',
                style: TextosDes.cuerpo,
                children: [
                  TextSpan(
                      text: '¡Inicia sesión ahora!',
                      style: TextosDes.link,
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.pushNamed(context, '/loginFP'))
                ]),
          ),
        )
      ],
    );
  }
}
