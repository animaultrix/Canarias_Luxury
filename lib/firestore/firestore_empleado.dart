import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore bd_Empleado = FirebaseFirestore.instance;

Future <String>  getEmpleadoCredencial() async{

  String adminCredencial= "";
  CollectionReference  collectionReference = bd_Empleado.collection('empleado');
  
  QuerySnapshot queryCredencial = await collectionReference.get();

    adminCredencial = queryCredencial.docs[0]['credencial'];


  return adminCredencial.toString();
}