part of 'notificaciones_bloc.dart';

@immutable
class NotificacionesState {
  final Map<int, Notificacion> notificaciones;
  final String accion;

  NotificacionesState({
    Map<int, Notificacion>? notificaciones,
    this.accion = '',
  }) : notificaciones = notificaciones ?? {};

  NotificacionesState copyWith({
    Map<int, Notificacion>? notificaciones,
    String? accion,
  }) =>
      NotificacionesState(
        accion: accion ?? this.accion,
        notificaciones: notificaciones ?? this.notificaciones,
      );

  NotificacionesState iniState() => NotificacionesState();
}
