
import 'package:cloud_firestore/cloud_firestore.dart';

class ClienteExistente {
  Future<bool> clienteExiste(String code) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference collectionReference = db.collection('cliente');

  QuerySnapshot querySnapshot = await collectionReference
      .where('code', isEqualTo: code)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

}