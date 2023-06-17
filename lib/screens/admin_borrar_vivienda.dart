import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore_ver_viviendas.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

class AdminBorrarVivienda extends StatefulWidget {
  const AdminBorrarVivienda({super.key});

  @override
  State<AdminBorrarVivienda> createState() => _AdminBorrarViviendaState();
}

class _AdminBorrarViviendaState extends State<AdminBorrarVivienda> {
  // Lista de viviendas
  Future<List<Map<String, dynamic>>>? _viviendas;

    Future<void> borrarVivienda(int id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionReference = db.collection('vivienda');

    QuerySnapshot querySnapshot = await collectionReference.where('id', isEqualTo: id).get();
    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.delete();
    }
  }


  @override
  void initState() {
    super.initState();
    _viviendas = getViviendas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrar vivienda'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _viviendas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> viviendas = snapshot.data!;
            return ListView.builder(
              itemCount: viviendas.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(viviendas[i]['nombre']),
                      subtitle: Text(
                          'Latitud: ${viviendas[i]['latitud']} | Longitud: ${viviendas[i]['longitud']} | Info: ${viviendas[i]['info']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await borrarVivienda(viviendas[i]['id']);
                          setState(() {
                            _viviendas = getViviendas();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Vivienda "${viviendas[i]['nombre']}" eliminada.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los datos de la base de datos'));
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

