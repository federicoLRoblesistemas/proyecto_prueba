part of 'bloc_prueba_bloc.dart';

 class BlocPruebaState extends Equatable {
  final bool isWorking;
  final String error;
  final String campoError;
  final String msjStatus;
  final String accion;
  final ModeloPruebaModel pruebaModel;
  final List<ModeloPruebaModel> lstpruebaModel;
  
  BlocPruebaState({
    this.isWorking = false,
      this.error = '',
      this.campoError = '',
      this.msjStatus = '',
      this.accion = '',
      ModeloPruebaModel? pruebaModel,
      List<ModeloPruebaModel>? lstpruebaModel
      })
      : pruebaModel = pruebaModel ?? const ModeloPruebaModel(),
        lstpruebaModel = lstpruebaModel ?? [];

  BlocPruebaState copyWith(
          {bool? isWorking,
          String? error,
          String? campoError,
          String? msjStatus,
          String? accion,
          ModeloPruebaModel? pruebaModel,
          List<ModeloPruebaModel>? lstpruebaModel}) =>
      BlocPruebaState(
          isWorking: isWorking ?? this.isWorking,
          error: error ?? this.error,
          campoError: campoError ?? this.campoError,
          msjStatus: msjStatus ?? this.msjStatus,
          accion: accion ?? this.accion,
          pruebaModel: pruebaModel ?? this.pruebaModel,
          lstpruebaModel: lstpruebaModel ?? this.lstpruebaModel);
  
  @override
  List<Object> get props => [
    isWorking,
        error,
        campoError,
        msjStatus,
        accion,
        pruebaModel,
        lstpruebaModel
  ];
}
