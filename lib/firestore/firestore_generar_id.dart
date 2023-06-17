import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> getNextId(String coleccion) async {
  FirebaseFirestore dbCrearVivienda = FirebaseFirestore.instance;
  CollectionReference collectionReference = dbCrearVivienda.collection(coleccion);

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
  return id + 1;
}
