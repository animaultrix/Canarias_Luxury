import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

Future<DocumentReference> crearCliente({required String email, required Map<String, dynamic> cuestionarioData, required String code}) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference collectionReference = db.collection('cliente');

  // Generar el ID autoincremental
  int newId = await getNextId('cliente');

  Map<String, dynamic> datos = {
    'id': newId,
    'mail': email,
    'nombre': cuestionarioData['nombre'],
    'pasaporteDNI': cuestionarioData['pasaporte'],
    'telefono': cuestionarioData['telefono'],
    'code': code,
  };

  return collectionReference.add(datos);
}
