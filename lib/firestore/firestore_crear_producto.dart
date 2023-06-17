import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future<void> crearProducto(Map<String,dynamic> formValues, File? image) async{

  FirebaseFirestore dbCrearVivienda = FirebaseFirestore.instance; 
  CollectionReference  collectionReference = dbCrearVivienda.collection('producto');
  
  int id = await getNextId('producto'); // Obtener el próximo ID autoincremental
  
  String? imageUrl;
  if (image != null) {
    
    Reference ref = storage.ref().child('productos').child('$id.jpg');
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
