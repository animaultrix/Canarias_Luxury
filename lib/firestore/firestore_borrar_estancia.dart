import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> eliminarEstancia(String code) async {
  // Obtener la instancia de la base de datos
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Obtener la referencia a la colección de estancias
  CollectionReference estanciasRef = db.collection('estancia');

  // Eliminar la estancia utilizando el código proporcionado
  await estanciasRef.doc(code).delete();
}
