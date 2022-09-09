import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proyecto_prueba/src/global/environment.dart';
import 'package:proyecto_prueba/src/models/modelo_prueba.dart';

part 'bloc_prueba_event.dart';
part 'bloc_prueba_state.dart';

class BlocPruebaBloc extends Bloc<BlocPruebaEvent, BlocPruebaState> {
  BlocPruebaBloc() : super(BlocPruebaState()) {
    on<OnNuevoModeloPrueba>(_onNuevoModeloPrueba);
    on<OnModificarModeloPrueba>(_onModificarModeloPrueba);
    on<OnValidarModeloPrueba>(_onValidarModeloPrueba);
    on<OnEliminarModeloPrueba>(_onEliminarModeloPrueba);
    // on<OnOrdenarModeloPrueba>(_onOrdenarModeloPrueba);
  }

  void _onNuevoModeloPrueba(OnNuevoModeloPrueba event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, pruebaModel: const ModeloPruebaModel(), error: '', accion: Environment.blocOnNuevoModeloPrueba));

    emit(state.copyWith(isWorking: false, pruebaModel: const ModeloPruebaModel(), error: '', accion: Environment.blocOnNuevoModeloPrueba));
  }

  void _onModificarModeloPrueba(OnModificarModeloPrueba event, Emitter emit) async {
    try {
      emit(
        state.copyWith(
          isWorking: true,
          pruebaModel: const ModeloPruebaModel(),
          error: '',
          accion: Environment.blocOnModificarModeloPrueba,
        ),
      );

      String error = '';
      ModeloPruebaModel pruebaModel = const ModeloPruebaModel();

      for (ModeloPruebaModel modelo in state.lstpruebaModel) {
        if (modelo.id == event.idModeloPrueba) {
          pruebaModel = modelo;
        }
      }

      emit(
        state.copyWith(
          isWorking: false,
          pruebaModel: pruebaModel,
          error: '',
          accion: Environment.blocOnModificarModeloPrueba,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: Environment.blocOnModificarModeloPrueba));
    }
  }

  Future<void> _onValidarModeloPrueba(
      OnValidarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: Environment.blocOnValidarModeloPrueba));

      String error = '';
      String campoError = '';
      ModeloPruebaModel pruebaModel = state.pruebaModel;

      if (pruebaModel.descripcion.isEmpty) {
          error = 'Falta Definir la descripcion';
          campoError = 'descripcion';
        } else {
          pruebaModel = pruebaModel
              .copyWith(data: {'descripcion': pruebaModel.descripcion.trim()});
        }
      

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          campoError: campoError,
          pruebaModel: pruebaModel,
          accion: Environment.blocOnValidarModeloPrueba));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: Environment.blocOnValidarModeloPrueba));
    }
  }

  Future<void> _onEliminarModeloPrueba(
      OnEliminarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: Environment.blocOnValidarModeloPrueba));

      
      ModeloPruebaModel pruebaModel = state.pruebaModel;

      if (pruebaModel.descripcion.isEmpty) {
          error = 'Falta Definir la descripcion';
          campoError = 'descripcion';
        } else {
          pruebaModel = pruebaModel
              .copyWith(data: {'descripcion': pruebaModel.descripcion.trim()});
        }
      

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          campoError: campoError,
          pruebaModel: pruebaModel,
          accion: Environment.blocOnValidarModeloPrueba));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: Environment.blocOnValidarModeloPrueba));
    }
  }
}
