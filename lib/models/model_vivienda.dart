import 'package:cloud_firestore/cloud_firestore.dart';

class Vivienda {
  final int id;
  final String info;
  final String latitud;
  final String longitud;
  final String nombre;

  Vivienda({
    required this.id,
    required this.info,
    required this.latitud,
    required this.longitud,
    required this.nombre,
  });

  factory Vivienda.fromMap(Map<String, dynamic> data) {
    return Vivienda(
      id: data['id'],
      info: data['info'],
      latitud: data['latitud'],
      longitud: data['longitud'],
      nombre: data['nombre'],
    );
  }
  factory Vivienda.fromSnapshot(DocumentSnapshot doc) {
    return Vivienda(
      id: doc['id'],
      info: doc['info'],
      latitud: doc['latitud'],
      longitud: doc['longitud'],
      nombre: doc['nombre'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitud': latitud,
      'longitud': longitud,
      'info': info,
      // Agrega otras propiedades aquí según sea necesario
    };
  }

}