import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/models/models.dart';

class FirestorePreEntrada {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarServicio(String idServicio, bool recogida, bool entrega, bool cuna) async {
    await _firestore.collection('servicio').doc(idServicio).set({
      'recogida': recogida,
      'entrega': entrega,
      'cuna': cuna,
    });
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> obtenerServicio(String idServicio) async {
    return await _firestore.collection('servicio').doc(idServicio).get();
  }
  Future<List<Servicio>> getServicios() async {
    QuerySnapshot querySnapshot = await _firestore.collection('servicio').get();
    List<Servicio> servicios = [];

    querySnapshot.docs.forEach((doc) {
      servicios.add(Servicio(
        code: doc.id,
        recogida: doc['recogida'],
        entrega: doc['entrega'],
        cuna: doc['cuna'],
      ));
    });

    return servicios;
  }
  Future<List<PreEstancia>> getEstanciasWithSalidaGreaterThanOrEqual() async {
  DateTime now = DateTime.now();
  DateTime currentDate = DateTime(now.year, now.month, now.day);
  Timestamp currentTime = Timestamp.fromDate(currentDate);

  QuerySnapshot querySnapshot = await _firestore
      .collection('estancia')
      .where('salida', isGreaterThanOrEqualTo: currentTime)
      .get();
  
  List<PreEstancia> preEstancias = [];

  for (var doc in querySnapshot.docs) {
    Estancia estancia = Estancia.fromSnapshot(doc);
    DocumentSnapshot<Map<String, dynamic>> servicioSnapshot = await obtenerServicio(estancia.code);

    if (servicioSnapshot.exists) {
      Servicio servicio = Servicio(
        code: servicioSnapshot.id,
        recogida: servicioSnapshot['recogida'],
        entrega: servicioSnapshot['entrega'],
        cuna: servicioSnapshot['cuna'],
      );

      // Verifica si al menos un campo de servicio es true
      if (servicio.recogida || servicio.entrega || servicio.cuna) {
        preEstancias.add(PreEstancia(estancia: estancia, servicio: servicio));
      }
    }
  }

  return preEstancias;
}



}
class Servicio {
  final String code;
  final bool recogida;
  final bool entrega;
  final bool cuna;

  Servicio({
    required this.code,
    required this.recogida,
    required this.entrega,
    required this.cuna,
  });
  
}
class PreEstancia {
  final Estancia estancia;
  final Servicio servicio;

  PreEstancia({
    required this.estancia,
    required this.servicio,
  });
}
