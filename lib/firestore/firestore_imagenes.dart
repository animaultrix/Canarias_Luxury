import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/models/model_carrusel_admin.dart';
import 'package:proyecto_dam/models/models.dart';


Future<List<Carrusel>> getImagenes({String? producto, String? ocio}) async {
  FirebaseFirestore dbproducto = FirebaseFirestore.instance;

  List<CollectionReference> collectionReferences = [];
  String tipo;
  if (producto != null && (producto == 'producto' || ocio == null)) {
    collectionReferences.add(dbproducto.collection(producto));
  }
  if (ocio != null && (ocio == 'ocio' || producto == null)) {
    collectionReferences.add(dbproducto.collection(ocio));
  }
  if (producto != null && ocio != null) {
    collectionReferences.add(dbproducto.collection(producto));
    collectionReferences.add(dbproducto.collection(ocio));
  }
  
  List<Carrusel> carruselList = [];

  for (var collectionReference in collectionReferences) {
    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        carruselList.add(Carrusel(
          id: data['id'] ?? 0,
          nombre: data['nombre'] ?? '',
          imagen: data['imagen'] ?? '',
          descripcion: data['descripcion'] ?? '',
          precio: data['precio'] ?? '',
          tipo: collectionReference.id,
        ));
      });
    });
  }

  return carruselList;
}


Future<List<Carrusel_admin>> getImagenesAdmin() async {
  FirebaseFirestore dbproducto = FirebaseFirestore.instance;
  CollectionReference collectionReference = dbproducto.collection('producto');

  List<Carrusel_admin> carruselList = [];

  await collectionReference.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      carruselList.add(Carrusel_admin(
        id: data['id'] ?? 0, 
        nombre: data['nombre'] ?? '',
        imagen: data['imagen'] ?? '', 
        descripcion: data['descripcion'] ?? '',
        precio: data['precio'] ?? '',
      ));
    });
  });

  return carruselList;
}