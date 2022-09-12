part of 'notificaciones_bloc.dart';

@immutable
abstract class NotificacionesEvent {}

///Este evento es el encargado de mostrar una nueva notificacion
/// - [nuevaNotificacion] Es la nueva modificacion a mostrar
class OnNuevaNotificacionEvent extends NotificacionesEvent {
  final Notificacion nuevaNotificacion;

  OnNuevaNotificacionEvent(this.nuevaNotificacion);
}

class OnEliminaNotificacionEvent extends NotificacionesEvent {
  final int indice;
  final Notificacion notificacion;
  OnEliminaNotificacionEvent(
      {required this.notificacion, required this.indice});
}
