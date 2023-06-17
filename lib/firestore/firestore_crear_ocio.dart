import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

FirebaseStorage st = FirebaseStorage.instance;

Future<void> crearOcio(Map<String,dynamic> formValues, File? image) async{

  FirebaseFirestore dbCrearVivienda = FirebaseFirestore.instance; 
  CollectionReference  collectionReference = dbCrearVivienda.collection('ocio');
  
  int id = await getNextId('ocio'); // Obtener el próximo ID autoincremental
  
  String? imageUrl;
  if (image != null) {
    
    Reference ref = st.ref().child('ocios').child('$id.jpg');
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() async {
      imageUrl = await ref.getDownloadURL();
    });
  }

  DocumentReference documentReference = collectionReference.doc();
  Map<String, dynamic> datos = {
    'id': id,
    'nombre': formValues['nombre'],
    'descripcion': formValues['descripcion'],
    'precio': formValues['precio'],
    'imagen': imageUrl ?? '',//si no hay imagen, se guarda una cadena vacía
  };
  documentReference.set(datos);
}
