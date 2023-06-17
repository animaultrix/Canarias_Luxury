import 'package:cloud_firestore/cloud_firestore.dart';

class Estancia {
  final String code;
  final DateTime entrada;
  final int id;
  final String idVivienda;
  final String mail;
  final DateTime salida;

  Estancia({
    required this.code,
    required this.entrada,
    required this.id,
    required this.idVivienda,
    required this.mail,
    required this.salida,
  });

  factory Estancia.fromMap(Map<String, dynamic> data) {
    return Estancia(
      code: data['code'],
      entrada: (data['entrada'] as Timestamp).toDate(),
      id: data['id'],
      idVivienda: data['id_vivienda'],
      mail: data['mail'],
      salida: (data['salida'] as Timestamp).toDate(),
    );
  }
  factory Estancia.fromSnapshot(DocumentSnapshot doc) {
  return Estancia(
    code: doc['code'],
    entrada: doc['entrada'].toDate(),
    id: doc['id'],
    idVivienda: doc['id_vivienda'],
    mail: doc['mail'],
    salida: doc['salida'].toDate(),
  );
}

  
}