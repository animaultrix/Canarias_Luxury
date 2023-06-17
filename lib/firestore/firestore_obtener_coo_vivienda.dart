import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/models/models.dart';

Future<List<double>> getViviendaCoordinates(BuildContext context) async {
  // Acceder a UsuarioModel
  UsuarioModel usuarioModel = Provider.of<UsuarioModel>(context, listen: false);
  String? code = usuarioModel.code;
  print('getViviendaCoordinates - code: $code');
  // Obtener la instancia de la base de datos
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Obtener el documento de la colección 'estancia' basado en el código
  DocumentSnapshot estanciaSnapshot = await db.collection('estancia').doc(code).get();
  print('getViviendaCoordinates - estanciaSnapshot: $estanciaSnapshot');


  // Verificar que los datos de la estancia son de tipo Map
  if (estanciaSnapshot.data() is Map<String, dynamic>) {
    Map<String, dynamic> estanciaData = estanciaSnapshot.data() as Map<String, dynamic>;
    print('getViviendaCoordinates - estanciaData: $estanciaData');
    // Obtener 'id_vivienda' del documento de la estancia
    int idVivienda = int.tryParse(estanciaData['id_vivienda'] ?? '') ?? 0;
    print('getViviendaCoordinates - idVivienda: $idVivienda');    

    // Obtener el documento de la colección 'vivienda' basado en 'id_vivienda'
    QuerySnapshot viviendaQuerySnapshot = await db.collection('vivienda').where('id', isEqualTo: idVivienda).get();
    print("viviendaQuerySnapshot.docs: ${viviendaQuerySnapshot.docs}");
    // Verificar que los datos de la vivienda son de tipo Map
    if (viviendaQuerySnapshot.docs.isNotEmpty) {
  DocumentSnapshot viviendaSnapshot = viviendaQuerySnapshot.docs.first;
  print('getViviendaCoordinates - viviendaSnapshot: $viviendaSnapshot');

  // Verificar que los datos de la vivienda existan y sean de tipo Map
  if (viviendaSnapshot.data() != null && viviendaSnapshot.data() is Map<String, dynamic>) {
    // Extraer los datos de la vivienda
    Map<String, dynamic> viviendaData = viviendaSnapshot.data() as Map<String, dynamic>;
    print('getViviendaCoordinates - viviendaData: $viviendaData');

    // Obtener las coordenadas de la vivienda (latitud y longitud)
    double latitud = double.tryParse(viviendaData['latitud'] ?? '') ?? 0;
    double longitud = double.tryParse(viviendaData['longitud'] ?? '') ?? 0;
    print('getViviendaCoordinates - Coordenadas: $latitud, $longitud');

    // Devolver las coordenadas de la vivienda
    return [latitud, longitud];
  }
  } else {
    print('getViviendaCoordinates - No se encontró un documento de vivienda con el id: $idVivienda');
  }

  }

  // En caso de error, devolver coordenadas predeterminadas
  return [0, 0];
}
