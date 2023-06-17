import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore bd = FirebaseFirestore.instance;

Future <String>  getAdminCredencial() async{
  
  String adminCredencial= "";
  CollectionReference  collectionReference = bd.collection('admin');
  
  QuerySnapshot queryCredencial = await collectionReference.get();

    adminCredencial = queryCredencial.docs[0]['credencial'];


  return adminCredencial.toString();
}