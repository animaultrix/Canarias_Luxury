import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateCliente(String code, Map<String, dynamic> newData) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference clientesRef = firestore.collection('cliente');
  
  // Consulta para obtener el documento que coincide con el campo 'code'
  QuerySnapshot querySnapshot = await clientesRef.where('code', isEqualTo: code).get();
  
  // Si no hay resultados, no se puede actualizar el documento
  if (querySnapshot.docs.isEmpty) {
    print('No se encontró ningún documento con el code proporcionado.');
    return;
  }

  // Si hay resultados, actualiza el primer documento que coincide con el campo 'code'
  DocumentReference clienteRef = querySnapshot.docs.first.reference;
  await clienteRef.update({
    'cuestionarioData': newData,
  });
}
