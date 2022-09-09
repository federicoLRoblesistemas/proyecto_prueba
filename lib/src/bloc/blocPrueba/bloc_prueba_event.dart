part of 'bloc_prueba_bloc.dart';

abstract class BlocPruebaEvent extends Equatable {
  const BlocPruebaEvent();

  @override
  List<Object> get props => [];
}

class OnNuevoModeloPrueba extends BlocPruebaEvent {
  const OnNuevoModeloPrueba();
}

class OnModificarModeloPrueba extends BlocPruebaEvent {
  final String idModeloPrueba;
  const OnModificarModeloPrueba({required this.idModeloPrueba});
}

class OnValidarModeloPrueba extends BlocPruebaEvent {
  final ModeloPruebaModel modeloPrueba;
  final int pagina;
  const OnValidarModeloPrueba(
      {required this.modeloPrueba, required this.pagina});
}

class OnEliminarModeloPrueba extends BlocPruebaEvent {
  final String idModeloPrueba;
  const OnEliminarModeloPrueba({required this.idModeloPrueba});
}

class OnOrdenarModeloPrueba extends BlocPruebaEvent {
  const OnOrdenarModeloPrueba();
}