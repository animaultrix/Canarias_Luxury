import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminBorrarOcio extends StatelessWidget {
  const AdminBorrarOcio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borrar ocio')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ocio').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> ocio = document.data() as Map<String, dynamic>;

              return ListTile(
                leading: ocio['imagen'] != null && ocio['imagen'].isNotEmpty
                    ? Image.network(ocio['imagen'])
                    : Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                title: Text(ocio['nombre'] ?? ''),
                subtitle: Text(ocio['descripcion'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await borrarOcio(ocio['id']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ocio borrado correctamente'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

Future<void> borrarOcio(int idOcio) async {
  FirebaseFirestore dbBorrarOcio = FirebaseFirestore.instance;
  CollectionReference collectionReference = dbBorrarOcio.collection('ocio');
  FirebaseStorage storage = FirebaseStorage.instance;

  QuerySnapshot querySnapshot = await collectionReference
      .where('id', isEqualTo: idOcio)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    String docId = querySnapshot.docs.first.id;
    Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;
    String? imageUrl = data['imagen'];

    // Eliminar imagen del Storage
    if (imageUrl != null && imageUrl.isNotEmpty) {
      Reference ref = storage.refFromURL(imageUrl);
      await ref.delete();
    }

    // Eliminar ocio de Firestore
    await collectionReference.doc(docId).delete();
  }
}
