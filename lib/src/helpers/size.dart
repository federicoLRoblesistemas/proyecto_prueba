import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get ancho => MediaQuery.of(this).size.width / 100;
  double get alto => MediaQuery.of(this).size.height / 100;

  double get padding {
    return MediaQuery.of(this).viewPadding.top;
  }

  double get anchoWithHorientacion {
    if (isvertical) {
      return MediaQuery.of(this).size.width / 100;
    } else {
      return MediaQuery.of(this).size.height / 100;
    }
  }

  double get altoWithHorientacion {
    if (isvertical) {
      return MediaQuery.of(this).size.height / 100;
    } else {
      return MediaQuery.of(this).size.width / 100;
    }
  }

  bool get isvertical =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  String? get route => ModalRoute.of(this)!.settings.name;
}
