import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Clase utilizado para las notificaciones del proyecto
/// - `key` Clave que identifica de forma unica a la notificacion para eliminarlo
/// - `titulo` La cabecera de la notificacion
/// - `descripcion` Informacion adicional sobre la notificacion
/// - `icono` Icono a utilizar para la notificacion
/// - `tipoNotificacion` Existen 3 tipos de notificacion " error,notificaicon,navegacion"
/// - `onTap` Si se trata del tipo de notificacion `TipoNotificacion.navegacion` se utiliza el onTap
class Notificacion extends Equatable {
  final String titulo;
  final String descripcion;
  final IconData? icono;
  final TipoNotificacion tipoNotificacion;
  final VoidCallback? onTap;

  const Notificacion(
      {this.titulo = '',
      this.descripcion = '',
      this.icono,
      TipoNotificacion? tipoNotificacion,
      this.onTap})
      : tipoNotificacion = tipoNotificacion ?? TipoNotificacion.notificacion;

  @override
  List<Object?> get props =>
      [titulo, descripcion, icono, tipoNotificacion, onTap];
}

///Enum utilizado para los tipos de notificaciones que se van a mostrar
/// - `error` Utilizado para mostrar una notificacion que represente un error de validacion, guardado,etc.
/// - `notificaicon` Utilizado para mostrar una notificacion que represente un proceso realizado exitosamente, informar sobre algo al usuario, etc.
/// - `navegacion` Utilizado para poder navegar a una vista al hacer click en la notificacion
enum TipoNotificacion {
  error,
  notificacion,
  confirmacion,
}
