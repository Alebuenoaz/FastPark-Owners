import 'dart:io';

import 'package:fast_park/design/textoCampos.dart';
import 'package:fast_park/design/textosDes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CorreoPass extends StatefulWidget {
  final String hintText;
  final IconData androidIcons;
  final IconData iOSIcons;
  final TextInputType texto;
  final bool isIOS;
  final bool obscureText;
  final void Function(String) onChanged;
  final String errorText;

  CorreoPass({
    @required this.hintText,
    @required this.androidIcons,
    @required this.iOSIcons,
    this.texto,
    @required this.isIOS,
    this.obscureText,
    @required this.onChanged,
    @required this.errorText,
  });

  @override
  _CorreoPassState createState() => _CorreoPassState();
}

class _CorreoPassState extends State<CorreoPass> {
  FocusNode _nodo;
  bool displayCuperError;
  TextEditingController _controller;

  @override
  void initState() {
    _nodo = FocusNode();
    _nodo.addListener(_handleFocusChange);
    displayCuperError = false;
    _controller = TextEditingController();
    super.initState();
  }

  void _handleFocusChange() {
    print('Focus changed');
    if (_nodo.hasFocus == false && widget.errorText != null) {
      displayCuperError = true;
    } else {
      displayCuperError = false;
    }

    widget.onChanged(_controller.text);
  }

  @override
  void dispose() {
    _nodo.removeListener(_handleFocusChange);
    _nodo.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (widget.isIOS) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TextosCampos.textBoxHorizonatal(),
          vertical: TextosCampos.textBoxVertical(),
        ),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              keyboardType:
                  (widget.texto != null) ? widget.texto : TextInputType.text,
              placeholder: widget.hintText,
              placeholderStyle: TextosCampos.placeholder(),
              style: TextosCampos.text(),
              textAlign: TextAlign.center,
              decoration: (displayCuperError)
                  ? TextosCampos.cupertinoErrorDes
                  : TextosCampos.cupertino,
              prefix: TextosCampos.iconPrefix(widget.iOSIcons),
              obscureText:
                  (widget.obscureText != null) ? widget.obscureText : false,
              onChanged: widget.onChanged,
              focusNode: _nodo,
              controller: _controller,
            ),
            (widget.errorText != null)
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.errorText,
                          style: TextosDes.error,
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TextosCampos.textBoxHorizonatal(),
          vertical: TextosCampos.textBoxVertical(),
        ),
        child: TextField(
          keyboardType:
              (widget.texto != null) ? widget.texto : TextInputType.text,
          cursorColor: TextosCampos.colorCursor(),
          style: TextosCampos.text(),
          textAlign: TextosCampos.textAlign(),
          decoration: TextosCampos.androidIcons(
              widget.hintText, widget.androidIcons, widget.errorText),
          obscureText:
              (widget.obscureText != null) ? widget.obscureText : false,
          onChanged: widget.onChanged,
        ),
      );
    }
  }
}
