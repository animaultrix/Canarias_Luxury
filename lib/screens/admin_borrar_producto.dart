import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminBorrarProducto extends StatefulWidget {
  @override
  _AdminBorrarProductoState createState() => _AdminBorrarProductoState();
}

class _AdminBorrarProductoState extends State<AdminBorrarProducto> {
  Future<List<Map<String, dynamic>>> obtenerProductos() async {
  List<Map<String, dynamic>> productos = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('producto')
      .get();

  querySnapshot.docs.forEach((doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      productos.add(data);
    }
  });

  return productos;
}


  Future<void> borrarProducto(int idProducto) async {
    FirebaseFirestore dbBorrarProducto = FirebaseFirestore.instance;
    CollectionReference collectionReference = dbBorrarProducto.collection('producto');
    FirebaseStorage storage = FirebaseStorage.instance;

    QuerySnapshot querySnapshot = await collectionReference
        .where('id', isEqualTo: idProducto)
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

      // Eliminar producto de Firestore
      await collectionReference.doc(docId).delete();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Borrar Producto')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los productos'));
          }

          List<Map<String, dynamic>> productos = snapshot.data ?? [];

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> producto = productos[index];
              return ListTile(
                leading: Image.network(producto['imagen']),
                title: Text(producto['nombre']),
                subtitle: Text(producto['descripcion']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await borrarProducto(producto['id']);
                    setState(() {}); // Actualiza el estado para que se vuelva a construir la lista
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
