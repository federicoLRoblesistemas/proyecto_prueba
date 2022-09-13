import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/blocPrueba/bloc_prueba_bloc.dart';
import 'package:proyecto_prueba/src/models/modelo_prueba.dart';
import 'package:proyecto_prueba/src/widgets/widgets.dart';

class PopAppAlta extends StatefulWidget {
  const PopAppAlta({
    Key? key,
  }) : super(key: key);

  @override
  State<PopAppAlta> createState() => PopAppAltaState();
}

class PopAppAltaState extends State<PopAppAlta> {
  late ModeloPruebaModel pruebaModel;
  bool isNuevo = false;
  TextStyle estilo = const TextStyle(
    color: Colors.white,
  );
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
          Text(
            (pruebaModel.descripcion.isEmpty) ? 'Alta item' : 'Edición Item',
           style: const TextStyle(
             fontSize: 20,
             color: Colors.black54,
             fontWeight: FontWeight.bold,
           ),),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  context.read<BlocPruebaBloc>().add(OnValidarModeloPrueba(modeloPrueba: pruebaModel));
                },
                child:  Text(
                  'Guardar',
                  style: estilo,
                )),
            if (!isNuevo)
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                  onPressed: () {
                    context.read<BlocPruebaBloc>().add(const OnEliminarModeloPrueba());
                  },
                  child:  Text(
                    'Eliminar',
                    style: estilo,
                  )),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(
                'Cancelar',
                style: estilo,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _ItemFormulario extends StatelessWidget {
  const _ItemFormulario({
    Key? key,
    required this.titulo,
    required this.valor,
    required this.onChanged,
    required this.isEditable,
  }) : super(key: key);

  final String titulo;
  final String valor;
  final Function(String) onChanged;
  final bool isEditable;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: TextfieldModelWidget.estandar(
            decoration: InputDecoration(enabled: isEditable),
            controller: TextEditingController(text: valor),
            maxWidth: double.infinity,
            labelTitulo: ModeloPruebaModel.titulosFormulario[titulo]!,
            onChanged: (value) {
              onChanged.call(value);
            },
          ),
        ),
      ],
    );
  }
}
