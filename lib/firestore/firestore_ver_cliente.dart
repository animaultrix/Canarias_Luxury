import 'package:cloud_firestore/cloud_firestore.dart';

//usar como List<Map<String, dynamic>> cliente = await getCliente();
Future<List<Map<String, dynamic>>> getCliente(String code) async {

  // Obtener la instancia de la base de datos
  FirebaseFirestore dbCliente = FirebaseFirestore.instance;
  // Obtener la referencia a la colección de cliente
  CollectionReference collectionReference = dbCliente.collection('cliente');
  // Filtrar la colección por el campo 'code' que coincida con el valor proporcionado
  Query query = collectionReference.where('code', isEqualTo: code);
  // Obtener los documentos de la colección filtrada
  QuerySnapshot querySnapshot = await query.get();
  // Crear una lista de cliente
  List<Map<String, dynamic>> cliente = []; 
  // Iterar sobre los documentos obtenidos y agregarlos a la lista cliente
  for (DocumentSnapshot doc in querySnapshot.docs) {
    cliente.add(doc.data() as Map<String, dynamic>);
  } 
  // Devolver la lista de viviendas tipo Map (clave-valor) 
  return cliente;
}
