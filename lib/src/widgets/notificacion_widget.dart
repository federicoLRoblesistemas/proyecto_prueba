
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/notificaciones/notificaciones_bloc.dart';
import 'package:proyecto_prueba/src/helpers/size.dart';
import 'package:proyecto_prueba/src/models/notificacion.dart';


class NotificacionWidget extends StatefulWidget {
  final int indice;
  final Notificacion notificacion;

  const NotificacionWidget(
      {super.key, required this.notificacion, required this.indice});

  @override
  State<NotificacionWidget> createState() => _NotificacionWidgetState();

  // const factory NotificacionWidget.notificacion({required String mensaje}) =
  //     _NotificacionModelWidget;

  // const factory NotificacionWidget.error({required String mensaje}) =
  //     _ErrorModelWidget;

  // const factory NotificacionWidget.confirmacion({required String mensaje}) =
  //     _ConfirmacionModelWidget;

  const factory NotificacionWidget.agregaNotificacion(
      {required Notificacion notificacion,
      required int indice}) = _NuevaNotificacionModelWidget;
}

class _NotificacionWidgetState extends State<NotificacionWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> bajar;
  late Animation<double> subir;
  late Animation<double> progress;
  final _key = GlobalKey();
  double anchoLinealProgress = 0.0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));

    opacidad = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.easeOut)));

    opacidadOut = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeOut)));

    bajar = Tween(begin: -60.0, end: 10.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.easeOut)));

    subir = Tween(begin: 20.0, end: -60.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut)));

    progress = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.65, 0.75, curve: Curves.easeOut)));

    controller.addListener(() {
      if (anchoLinealProgress == 0.0) {
        _getSize();
      }
      if (controller.status == AnimationStatus.completed) {
        context.read<NotificacionesBloc>().add(OnEliminaNotificacionEvent(
            indice: widget.indice, notificacion: widget.notificacion));
      }
    });

    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _getSize() {
    final size = _key.currentContext?.size;
    if (size != null) {
      anchoLinealProgress = size.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? childRect) {
        return Transform.translate(
          offset: Offset(0, bajar.value),
          child: Opacity(
            opacity: opacidad.value,
            child: Transform.translate(
                offset: Offset(0, subir.value),
                child: Opacity(
                  opacity: opacidadOut.value,
                  child: Container(
                    key: _key,
                    constraints: BoxConstraints(
                        maxWidth: context.ancho * 100, minWidth: 0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.notificacion.icono ??
                                    _determinarIcono(
                                        widget.notificacion.tipoNotificacion),
                                color: _determinarColor(
                                    widget.notificacion.tipoNotificacion),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  widget.notificacion.descripcion,
                                  style: TextStyle(
                                    color: _determinarColor(
                                      widget.notificacion.tipoNotificacion),
                                  ),                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: _determinarColor(
                                  widget.notificacion.tipoNotificacion),
                            ),
                            height: 3,
                            width: anchoLinealProgress * controller.value,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  Color _determinarColor(TipoNotificacion tipo) {
    switch (tipo) {
      case TipoNotificacion.notificacion:
        return Theme.of(context).primaryColor;
      case TipoNotificacion.error:
        return Colors.redAccent;

      default:
        return Colors.green;
    }
  }
}

IconData _determinarIcono(TipoNotificacion tipo) {
  switch (tipo) {
    case TipoNotificacion.notificacion:
      return Icons.info_outline;
    case TipoNotificacion.error:
      return Icons.error_outline_sharp;

    default:
      return Icons.check_circle_outline;
  }
}

// class _NotificacionModelWidget extends NotificacionWidget {
//   const _NotificacionModelWidget({required String mensaje})
//       : super(
//             mensaje: mensaje,
//             color: const Color(0xff3367D6),
//             icono: const Icon(Icons.info));
// }

// class _ErrorModelWidget extends NotificacionWidget {
//   const _ErrorModelWidget({required String mensaje})
//       : super(
//             mensaje: mensaje,
//             color: Colors.red,
//             icono: const Icon(Icons.dangerous_outlined));
// }

// class _ConfirmacionModelWidget extends NotificacionWidget {
//   const _ConfirmacionModelWidget({required String mensaje})
//       : super(
//             color: Colors.green,
//             icono: const Icon(Icons.check_box_outlined));
// }
class _NuevaNotificacionModelWidget extends NotificacionWidget {
  const _NuevaNotificacionModelWidget(
      {required Notificacion notificacion, required int indice})
      : super(notificacion: notificacion, indice: indice);
}
