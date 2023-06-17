import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

class AdminBorrarPOI extends StatefulWidget {
  const AdminBorrarPOI({super.key});

  @override
  State<AdminBorrarPOI> createState() => _AdminBorrarPOIState();
}

class _AdminBorrarPOIState extends State<AdminBorrarPOI> {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? futurePOI;

  @override
  void initState() {
    super.initState();
    futurePOI = obtenerPOI();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> obtenerPOI() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('poi')
        .orderBy('nombre', descending: false)
        .get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrar POI'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        future: futurePOI,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(docs[i].data()['nombre']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await eliminarPOI(docs[i].id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('POI "${docs[i].data()['nombre']}" eliminado.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      setState(() {
                        futurePOI = obtenerPOI();
                      });
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al obtener los datos de la base de datos'));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
Future<void> eliminarPOI(String docId) async {
  await FirebaseFirestore.instance.collection('poi').doc(docId).delete();
}
