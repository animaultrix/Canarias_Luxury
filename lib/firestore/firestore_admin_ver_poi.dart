import 'package:cloud_firestore/cloud_firestore.dart';

//usar como List<Map<String, dynamic>> pois = await getViviendas();
Future<List<Map<String, dynamic>>> getPOI(double centerLat, double centerLon) async {

  // Obtener la instancia de la base de datos
  FirebaseFirestore bdpoi = FirebaseFirestore.instance;
  // Obtener la referencia a la colección de pois
  CollectionReference collectionReference = bdpoi.collection('poi');
  // Obtener los documentos de la colección
  QuerySnapshot querySnapshot = await collectionReference.get();
  // Crear una lista de pois
  List<Map<String, dynamic>> pois = [];
  // Recorrer los documentos de la colección
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> poi = {};
    if (querySnapshot.docs.isNotEmpty) {
      // Obtener los datos de todas las pois 
      dynamic data = documentSnapshot.data();      
      // Verificar que los datos de la poi son de tipo Map
      if (data is Map<String, dynamic>) {
        poi = data;
      }
    } 
  // Agregar la poi a la lista
  pois.add(poi);
  print('clase getPOI - POI agregado: $poi');
  }
  // Devolver la lista de pois tipo Map (clave-valor) 
  return pois;
}