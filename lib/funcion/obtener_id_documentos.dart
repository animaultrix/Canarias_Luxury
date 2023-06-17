import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/http/consulta_fecha.dart';

class GetIdDocumentos {
  static Future<Set<String>> getDocumentIdsFromCollection(String collectionName) async {

    // Obtener la fecha actual en Canarias
    DateTime serverTimestamp = await getCurrentTimeInCanarias();

    // Crear una referencia a la colección
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection(collectionName);

    // Crear una consulta que filtre los documentos en función de las fechas deseadas
    Query query = collectionReference
        .where('salida', isGreaterThan: serverTimestamp)
        .orderBy('salida', descending: false);

    // Obtener los documentos que coinciden con la consulta
    QuerySnapshot querySnapshot = await query.get();

    Set<String> documentIds = {};

    for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
      documentIds.add(doc.id);
    }

    return documentIds;
  }
}
