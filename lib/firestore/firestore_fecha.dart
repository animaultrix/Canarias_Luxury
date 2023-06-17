import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<DateTime> getFecha(String documentoId) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('estancia')
        .doc(documentoId)
        .get();
    Timestamp fechaTimestamp = snapshot.get('salida');
    DateTime fechaDateTime = fechaTimestamp.toDate();
    //HH para 24 horas, hh para 12 horas
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(fechaDateTime);
    DateTime fecha = DateTime.parse(formattedDate);
    print("fecha en canarias: $fecha");
    return fecha;
  } catch (e) {
    // En caso de error, se devuelve una fecha por defecto
    return DateTime(1999, 1, 1);
  }
}




