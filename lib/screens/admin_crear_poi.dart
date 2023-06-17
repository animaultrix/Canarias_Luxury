import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminCrearPOI extends StatefulWidget {
  const AdminCrearPOI({super.key});

  @override
  State<AdminCrearPOI> createState() => _AdminCrearPOIState();
}

class _AdminCrearPOIState extends State<AdminCrearPOI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formValues = {
    'nombre': '',
    'latitud': '',
    'longitud': '',
    'info': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear POI'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  formValues['nombre'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitud'),
                onSaved: (value) {
                  formValues['latitud'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitud'),
                onSaved: (value) {
                  formValues['longitud'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Info'),
                onSaved: (value) {
                  formValues['info'] = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await crearPOI(formValues);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('POI "${formValues['nombre']}" creado.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Crear POI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> crearPOI(Map<String, dynamic> formValues) async {
  FirebaseFirestore dbCrearPOI = FirebaseFirestore.instance;
  CollectionReference collectionReference = dbCrearPOI.collection('poi');

  // Obtener el último documento agregado para obtener su ID
  QuerySnapshot snapshot = await collectionReference.orderBy('id', descending: true).limit(1).get();
  int id = 0;
  if (snapshot.docs.isNotEmpty && snapshot.docs[0].data() != null) {
    dynamic data = snapshot.docs[0].data();
    if (data is Map<String, dynamic>) {
      dynamic idData = data['id'];
      if (idData is int) {
        id = idData;
      }
    }
  }
  // Crear el nuevo documento con un ID autoincremental
  DocumentReference documentReference = collectionReference.doc();
  Map<String, dynamic> datos = {
    'id': id + 1, // Incrementa el último ID obtenido
    'nombre': formValues['nombre'],
    'latitud': formValues['latitud'],
    'longitud': formValues['longitud'],
    'info': formValues['info'],
  };
  documentReference.set(datos);
}

