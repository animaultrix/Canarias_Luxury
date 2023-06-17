import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> obtenerEstanciasConFechaSalidaSuperior() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference estanciasRef = db.collection('estancia');
  DateTime now = DateTime.now();
  
  // Elimina la parte de hora y minutos de la fecha actual
  DateTime today = DateTime(now.year, now.month, now.day);
  
  Timestamp todayTimestamp = Timestamp.fromDate(today);

  QuerySnapshot querySnapshot = await estanciasRef
      .where('salida', isGreaterThanOrEqualTo: todayTimestamp)
      .get();

  List<Map<String, dynamic>> estancias = [];

  for (QueryDocumentSnapshot<Object?> documentSnapshot in querySnapshot.docs) {
    estancias.add(documentSnapshot.data() as Map<String, dynamic>);
  }

  return estancias;
}

