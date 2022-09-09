import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_prueba_event.dart';
part 'bloc_prueba_state.dart';

class BlocPruebaBloc extends Bloc<BlocPruebaEvent, BlocPruebaState> {
  BlocPruebaBloc() : super(BlocPruebaInitial()) {
    on<BlocPruebaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
