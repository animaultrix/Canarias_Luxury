import 'package:cloud_firestore/cloud_firestore.dart';

//usar como List<Map<String, dynamic>> viviendas = await getViviendas();
Future<List<Map<String, dynamic>>> getViviendas() async {

  // Obtener la instancia de la base de datos
  FirebaseFirestore dbViviendas = FirebaseFirestore.instance;
  // Obtener la referencia a la colección de viviendas
  CollectionReference collectionReference = dbViviendas.collection('vivienda');
  // Obtener los documentos de la colección
  QuerySnapshot querySnapshot = await collectionReference.get();
  // Crear una lista de viviendas
  List<Map<String, dynamic>> viviendas = [];
  // Recorrer los documentos de la colección
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> vivienda = {};
    if (querySnapshot.docs.isNotEmpty) {
      // Obtener los datos de todas las viviendas 
      dynamic data = documentSnapshot.data();      
      // Verificar que los datos de la vivienda son de tipo Map
      if (data is Map<String, dynamic>) {
        vivienda = data;
      }
    } 
  // Agregar la vivienda a la lista
  viviendas.add(vivienda);
  }
  // Devolver la lista de viviendas tipo Map (clave-valor) 
  return viviendas;
}
