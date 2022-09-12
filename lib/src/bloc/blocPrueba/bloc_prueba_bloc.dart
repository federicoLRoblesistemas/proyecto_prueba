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
    on<OnGuardarModeloPrueba>(_onOnGuardarModeloPrueba);
    on<OnEliminarModeloPrueba>(_onEliminarModeloPrueba);
    on<OnOrdenarModeloPrueba>(_onOrdenarModeloPrueba);
  }

  void _onNuevoModeloPrueba(OnNuevoModeloPrueba event, Emitter emit) async {
    emit(state.copyWith(isWorking: true, pruebaModel: const ModeloPruebaModel(), error: '', accion: Environment.blocOnNuevoModeloPrueba));

    emit(state.copyWith(isWorking: false, error: '', accion: Environment.blocOnNuevoModeloPrueba));
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
      emit(state.copyWith(isWorking: false, error: e.toString(), accion: Environment.blocOnModificarModeloPrueba));
    }
  }

  Future<void> _onValidarModeloPrueba(OnValidarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(isWorking: true, error: '', accion: Environment.blocOnValidarModeloPrueba));

      String error = '';
      String campoError = '';
      ModeloPruebaModel pruebaModel = event.modeloPrueba;

      if (pruebaModel.descripcion.isEmpty) {
        error = 'Falta Definir la descripción';
        campoError = 'descripcion';
      }
      if (pruebaModel.id.isEmpty) {
        error = 'Falta Definir el ID';
        campoError = 'id';
      }

      ///se busca coincidencias en la lista para guardar o modificar
      if (error.isEmpty) {
        pruebaModel = pruebaModel.copyWith(data: {
          'descripcion': pruebaModel.descripcion.trim(),
        }, id: pruebaModel.id);
      }

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          campoError: campoError,
          pruebaModel: pruebaModel,
          accion: Environment.blocOnValidarModeloPrueba));
    } catch (e) {
      emit(state.copyWith(isWorking: false, error: e.toString(), accion: Environment.blocOnValidarModeloPrueba));
    }
  }

  Future<void> _onEliminarModeloPrueba(OnEliminarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(isWorking: true, error: '', accion: Environment.blocOnEliminarModeloPrueba));

      ModeloPruebaModel pruebaModel = state.pruebaModel;
      List<ModeloPruebaModel> lstpruebaModel = state.lstpruebaModel;

      //TODO: Controlar que lista no esta vacia???
      for (ModeloPruebaModel modelo in state.lstpruebaModel) {
        if (modelo.id == pruebaModel.id) {
          lstpruebaModel.remove(modelo);
        }
      }

      emit(state.copyWith(
          isWorking: false,
          msjStatus: '',
          pruebaModel: pruebaModel,
          lstpruebaModel: lstpruebaModel,
          accion: Environment.blocOnEliminarModeloPrueba));
    } catch (e) {
      emit(state.copyWith(isWorking: false, error: e.toString(), accion: Environment.blocOnEliminarModeloPrueba));
    }
  }

  Future<void> _onOnGuardarModeloPrueba(OnGuardarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(isWorking: true, accion: Environment.blocOnGuardarModeloPrueba));

      ModeloPruebaModel pruebaModel = state.pruebaModel;
      List<ModeloPruebaModel> lstpruebaModel = state.lstpruebaModel;

      if (state.error.isEmpty) {
        for (ModeloPruebaModel modelo in state.lstpruebaModel) {
          if (modelo.id == pruebaModel.id) {
            lstpruebaModel.removeWhere((element) => element.id == pruebaModel.id);
          }
        }
        lstpruebaModel.add(pruebaModel);
      }

      emit(state.copyWith(
        isWorking: false,
        pruebaModel: pruebaModel,
        lstpruebaModel: lstpruebaModel,
        accion: Environment.blocOnGuardarModeloPrueba,
      ));

      // if (error.isEmpty) {
      //   add(const OnObtenerlstBotCategoria());
      // }
    } catch (e) {
      emit(state.copyWith(isWorking: false, error: e.toString(), accion: Environment.blocOnGuardarModeloPrueba));
    }
  }

  //
  Future<void> _onOrdenarModeloPrueba(OnOrdenarModeloPrueba event, Emitter emit) async {
    try {
      emit(state.copyWith(isWorking: true, error: '', accion: Environment.blocOnOrdenarModeloPrueba));
      String error = '';

      List<ModeloPruebaModel> lstpruebaModel = state.lstpruebaModel;
      if (lstpruebaModel.isNotEmpty) {
        lstpruebaModel.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
      } else {
        error = 'La lista que intenta ordenar se encuentra vacia';
      }

      emit(state.copyWith(isWorking: false, lstpruebaModel: lstpruebaModel, error: error, accion: Environment.blocOnOrdenarModeloPrueba));
    } catch (e) {
      emit(state.copyWith(isWorking: false, accion: Environment.blocOnOrdenarModeloPrueba));
    }
  }
}
