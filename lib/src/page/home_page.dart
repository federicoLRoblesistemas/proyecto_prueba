import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/blocPrueba/bloc_prueba_bloc.dart';
import 'package:proyecto_prueba/src/bloc/notificaciones/notificaciones_bloc.dart';
import 'package:proyecto_prueba/src/global/environment.dart';
import 'package:proyecto_prueba/src/models/notificacion.dart';
import 'package:proyecto_prueba/src/widgets/notificacion_widget.dart';
import 'package:proyecto_prueba/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const ViewLista(),
          BlocBuilder<NotificacionesBloc, NotificacionesState>(
            builder: (context, state) {
              return Column(
                  children: state.notificaciones.entries
                      .map((e) => NotificacionWidget.agregaNotificacion(indice: e.key, notificacion: e.value))
                      .toList());
            },
          ),
        ],
      ),
    );
  }
}

class ViewLista extends StatelessWidget {
  const ViewLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocPruebaBloc, BlocPruebaState>(
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.error.isEmpty) {
            if (state.accion == Environment.blocOnModificarModeloPrueba || state.accion == Environment.blocOnNuevoModeloPrueba) {
              showDialog<String>(context: context, builder: (context) => const PopAppAlta());
              log(state.accion);
            }
            if (state.accion == Environment.blocOnValidarModeloPrueba) {
              log(state.accion);
              context.read<BlocPruebaBloc>().add(const OnGuardarModeloPrueba());
            }
            if (state.accion == Environment.blocOnGuardarModeloPrueba) {
              context.read<NotificacionesBloc>().add(
                OnNuevaNotificacionEvent(
                  const Notificacion(
                    descripcion: 'Item guardado con exito!',
                    tipoNotificacion: TipoNotificacion.confirmacion,
                    titulo: 'Exito',
                  ),
                ),
              );
              Navigator.of(context).pop();
            }
            if (state.accion == Environment.blocOnEliminarModeloPrueba) {
              context.read<NotificacionesBloc>().add(
                OnNuevaNotificacionEvent(
                  const Notificacion(
                    descripcion: 'Item eliminado con exito!',
                    tipoNotificacion: TipoNotificacion.confirmacion,
                    titulo: 'Exito',
                  ),
                ),
              );
              Navigator.of(context).pop();
            }
          } else {
            context.read<NotificacionesBloc>().add(
              OnNuevaNotificacionEvent(
                Notificacion(
                  descripcion: state.error,
                  tipoNotificacion: TipoNotificacion.error,
                  titulo: 'Error',
                ),
              ),
            );
          }
        },
        child: Scaffold(
          body: Center(
              child: Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 500,
              width: 600,
              child: Column(
                children: const [
                  _TituloPrincipal(),
                  SizedBox(
                    height: 10,
                  ),
                  _BotonOrdenarTabla(),
                  _TablaElementos(),
                  SizedBox(
                    height: 15,
                  ),
                  _BotonNuevoModelo()
                ],
              ),
            ),
          )),
        ));
  }
}

class _BotonNuevoModelo extends StatelessWidget {
  const _BotonNuevoModelo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        context.read<BlocPruebaBloc>().add(const OnNuevoModeloPrueba());
      },
      child: const Text(
        'Nuevo Modelo',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class _TablaElementos extends StatelessWidget {
  const _TablaElementos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPruebaBloc, BlocPruebaState>(
      builder: (context, state) {
        return Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffF5F5F5),
              ),
              constraints: const BoxConstraints(minHeight: 150),
              width: double.infinity,
              child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: 0,
                  headingRowHeight: 20,
                  dataRowHeight: 20,
                  headingRowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.2)),
                  columns: const [
                    DataColumn(
                      label: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'ID del Item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Descripción del Item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    if (state.lstpruebaModel.isNotEmpty)
                      ...state.lstpruebaModel
                          .map(
                            (e) => DataRow(
                              cells: [
                                DataCell(
                                  Padding(padding: const EdgeInsets.only(left: 10), child: Text(e.id)),
                                  onTap: () => context.read<BlocPruebaBloc>().add(OnModificarModeloPrueba(idModeloPrueba: e.id)),
                                ),
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(e.descripcion),
                                  ),
                                  onTap: () => context.read<BlocPruebaBloc>().add(OnModificarModeloPrueba(idModeloPrueba: e.id)),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class _BotonOrdenarTabla extends StatelessWidget {
  const _BotonOrdenarTabla({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          context.read<BlocPruebaBloc>().add(const OnOrdenarModeloPrueba());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black54,
              ),
              Text(
                'Ordenar',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TituloPrincipal extends StatelessWidget {
  const _TituloPrincipal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Lista de elementos',
      style: TextStyle(
        fontSize: 25,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
