import 'package:cloud_firestore/cloud_firestore.dart';

void crearPOI(Map<String,dynamic> formValues) async{
  FirebaseFirestore dbCrearPOI = FirebaseFirestore.instance; 
  CollectionReference collectionReference = dbCrearPOI.collection('poi');

  // Obtener el último documento agregado para obtener su ID
  QuerySnapshot snapshot = await collectionReference.orderBy('id', descending: true).limit(1).get();
  int id = 0;
  if (snapshot.docs.isNotEmpty && snapshot.docs[0].data() != null) {
    dynamic data = snapshot.docs[0].data();
    if (data is Map<String, dynamic>) {
      dynamic idData = data['id'];
      if (idData is int) {
        id = idData;
      }
    }
  }
  // Crear el nuevo documento con un ID autoincremental
  DocumentReference documentReference = collectionReference.doc();
  Map<String, dynamic> datos = {
    'id': id + 1, // Incrementa el último ID obtenido
    'nombre': formValues['nombre'],
    'latitud': formValues['latitud'],
    'longitud': formValues['longitud'],
    'info': formValues['info'],
  };
  documentReference.set(datos);
}
