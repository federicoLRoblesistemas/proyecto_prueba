import 'dart:convert';

import 'package:equatable/equatable.dart';

ModeloPrueba modeloPruebaFromJson(String str) =>
    ModeloPrueba.fromJson(json.decode(str));

String modeloPruebaToJson(ModeloPrueba data) => json.encode(data.toJson());

class ModeloPrueba extends Equatable {
  final String id;
  final String descripcion;

  const ModeloPrueba({
    this.id = '',
    this.descripcion = '',
  });

  ModeloPrueba copyWith({
    String? id,
    String? descripcion,
  }) {
    return ModeloPrueba(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  factory ModeloPrueba.fromJson(Map<String, dynamic> json) {
    final chatbotModel = ModeloPrueba(
      id: (json.containsKey("id")) ? json["id"].toString() : '',
      descripcion: (json.containsKey("descripcion"))
          ? json["descripcion"].toString()
          : '',
    );
    return chatbotModel;
  }

  Map<String, dynamic> toJson() => {
        "proyectId": id,        
        "descripcion": descripcion,        
      };
  

  @override
  List<Object?> get props => [id,descripcion];

  static Map<String, String> titulosFormulario = {
    'id': 'ID',
    'descripcion': 'Descripcion',    
  };
}
