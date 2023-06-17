
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_generar_id.dart';

void crearEstancia(Map<String,dynamic> formValues, String code) async{

  FirebaseFirestore dbCrearVivienda = FirebaseFirestore.instance; 
  CollectionReference  collectionReference = dbCrearVivienda.collection('estancia');
  
  int id = await getNextId('estancia'); // Obtener el próximo ID autoincremental

  DateTime entrada = DateTime.parse(formValues['entrada']);
  DateTime salida = DateTime.parse(formValues['salida']);

  Timestamp entradaTimestamp = Timestamp.fromDate(entrada);
  Timestamp salidaTimestamp = Timestamp.fromDate(salida);

  //usa code como id de la estancia y no como un campo mas de esta  
  DocumentReference documentReference = collectionReference.doc(code);
  Map<String, dynamic> datos = {
    'id': id, // Incrementa el último ID obtenido
    'mail': formValues['mail'],
    'entrada': entradaTimestamp,
    'salida': salidaTimestamp,
    'code': formValues['code'],
    'id_vivienda': formValues['id_vivienda'],
  };
  documentReference.set(datos);
}
