import 'dart:convert';

import 'package:equatable/equatable.dart';

ModeloPruebaModel modeloPruebaFromJson(String str) =>
    ModeloPruebaModel.fromJson(json.decode(str));

String modeloPruebaToJson(ModeloPruebaModel data) => json.encode(data.toJson());

class ModeloPruebaModel extends Equatable {
  final String id;
  final String descripcion;

  const ModeloPruebaModel({
    this.id = '',
    this.descripcion = '',
  });

  ModeloPruebaModel copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) {
    return ModeloPruebaModel(
      id: id ?? this.id,
      descripcion: data?['descripcion'] ?? descripcion,
    );
  }

  factory ModeloPruebaModel.fromJson(Map<String, dynamic> json) {
    final chatbotModel = ModeloPruebaModel(
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
