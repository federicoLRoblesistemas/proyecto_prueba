import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/blocPrueba/bloc_prueba_bloc.dart';
import 'package:proyecto_prueba/src/global/environment.dart';
import 'package:proyecto_prueba/src/models/modelo_prueba.dart';
import 'package:proyecto_prueba/src/widgets/textfield_widget.dart';

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
            showDialog<String>(context: context, builder: (context) => const PopAppAlta());
            log(state.accion);
          }
          if (state.accion == Environment.blocOnValidarModeloPrueba) {
            log(state.accion);
            context.read<BlocPruebaBloc>().add(const OnGuardarModeloPrueba());
          }
          if (state.accion == Environment.blocOnGuardarModeloPrueba) {
            log(state.accion);
            log('Item Guardado con exito');
            Navigator.of(context).pop();
          }
          if (state.accion == Environment.blocOnEliminarModeloPrueba) {
            log(state.accion);
            log('Item Eliminado con exito');
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        return Center(
            child: Card(
          child: Container(
            height: 600,
            width: 500,
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
                    : const Text('No hay elementos en la lista'),
                TextButton(
                    onPressed: () {
                      context.read<BlocPruebaBloc>().add(const OnNuevoModeloPrueba());
                    },
                    child: const Text('Nuevo Modelo'))
              ],
            ),
          ),
        ));
      },
    );
  }
}

class PopAppAlta extends StatefulWidget {
  const PopAppAlta({
    Key? key,
  }) : super(key: key);

  @override
  State<PopAppAlta> createState() => _PopAppAltaState();
}

class _PopAppAltaState extends State<PopAppAlta> {
  late ModeloPruebaModel pruebaModel;
  bool isNuevo = false;

  @override
  void initState() {
    super.initState();
    pruebaModel = context.read<BlocPruebaBloc>().state.pruebaModel;
    isNuevo = pruebaModel.id.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text((pruebaModel.descripcion.isEmpty) ? 'Alta item' : 'Edición Item'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...pruebaModel.toJson().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _ItemFormulario(
                    isEditable: (e.key == 'id') ? isNuevo : true,
                    titulo: e.key,
                    valor: e.value,
                    onChanged: (valor) {
                      print(e.key);
                      if (e.key == 'id') {
                        pruebaModel = pruebaModel.copyWith(id: valor);
                      } else {
                        pruebaModel = pruebaModel.copyWith(data: {e.key: valor});
                      }
                    },
                  ),
                ),
              ),
        ],
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  context.read<BlocPruebaBloc>().add(OnValidarModeloPrueba(modeloPrueba: pruebaModel));
                },
                child: const Text('Guardar')),
            if (!isNuevo)
              TextButton(
                  onPressed: () {
                    context.read<BlocPruebaBloc>().add(const OnEliminarModeloPrueba());
                  },
                  child: const Text('Eliminar')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        )
      ],
    );
  }
}

class _ItemFormulario extends StatelessWidget {
  const _ItemFormulario(
      {
        Key? key, 
        required this.titulo, 
        required this.valor, 
        required this.onChanged, 
        required this.isEditable,
        this.margenInferior, 
        this.isLabel = false, 
        })
      : super(key: key);

  final String titulo;
  final String valor;
  final Function(String) onChanged;
  final bool isEditable;
  final double? margenInferior;
  final bool? isLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: TextfieldModelWidget.estandar(
            decoration: InputDecoration(
              enabled: isEditable
            ),
            controller: TextEditingController(text: valor),
            maxWidth: 350,
            labelTitulo: ModeloPruebaModel.titulosFormulario[titulo]!,
            onChanged: (value) {
              onChanged.call(value);
            },
          ),
        ),
        SizedBox(
          height: margenInferior ?? 0,
        ),
      ],
    );
  }
}
