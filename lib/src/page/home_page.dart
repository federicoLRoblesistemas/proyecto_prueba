import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/blocPrueba/bloc_prueba_bloc.dart';
import 'package:proyecto_prueba/src/global/environment.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ViewLista(),
    );
  }
}

class ViewLista extends StatelessWidget {
  const ViewLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocPruebaBloc, BlocPruebaState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.error.isEmpty) {
          if (state.accion == Environment.blocOnModificarModeloPrueba || state.accion == Environment.blocOnNuevoModeloPrueba) {
            // showDialog<String>(
            //       context: context,
            //       builder: (context) => Container()
            // );
            log(state.accion);
          }
        }
      },
      builder: (context, state) {
        return Center(
            child: Column(
          children: [
            const Text('Lista de elementos'),
            const SizedBox(
              height: 20,
            ),
            state.lstpruebaModel.isNotEmpty
                ? DataTable(
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    headingRowHeight: 20,
                    dataRowHeight: 20,
                    headingRowColor: MaterialStateProperty.all<Color>(const Color(0xffF5F5F5)),
                    columns: const [
                        DataColumn(label: Text('ID del Item')),
                        DataColumn(label: Text('Descripción del Item'))
                      ],
                    rows: [
                        ...state.lstpruebaModel
                            .map((e) => DataRow(cells: [
                                  DataCell(
                                    Text(e.id),
                                    onTap: () => context.read<BlocPruebaBloc>().add(OnModificarModeloPrueba(idModeloPrueba: e.id)),
                                  ),
                                  DataCell(
                                    Text(e.descripcion),
                                    onTap: () => context.read<BlocPruebaBloc>().add(OnModificarModeloPrueba(idModeloPrueba: e.id)),
                                  ),
                                ]))
                            .toList(),
                      ])
                : Container(),
            TextButton(
              onPressed: () {
              context.read<BlocPruebaBloc>().add(event)
            }, child: child)
          ],
        ));
      },
    );
  }
}
