import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore_borrar_estancia.dart';
import 'package:proyecto_dam/firestore/firestore_ver_estancia.dart';

class AdminBorrarEstancia extends StatefulWidget {
  const AdminBorrarEstancia({Key? key}) : super(key: key);

  @override
  _AdminBorrarEstanciaState createState() => _AdminBorrarEstanciaState();
}

class _AdminBorrarEstanciaState extends State<AdminBorrarEstancia> {
  final ValueNotifier<bool> _refreshListNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borrar estancia')),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: _refreshListNotifier,
          builder: (BuildContext context, bool refresh, Widget? child) {
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: obtenerEstanciasConFechaSalidaSuperior(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar las estancias');
                } else {
                  List<Map<String, dynamic>> estancias = snapshot.data!;
                  return ListView.builder(
                    itemCount: estancias.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> estancia = estancias[index]; // Define la variable 'estancia'
                      return ExpansionTile(
                      title: Text('ID de la vivienda: ${estancia['id_vivienda']}'),
                        children: [
                            ListTile(
                              title: Text('Mail: ${estancia['mail']}'),
                             ),
                            ListTile(
                              title: Text('Fecha de entrada: ${estancia['entrada'].toDate()}'),
                            ),
                            ListTile(
                              title: Text('Fecha de salida: ${estancia['salida'].toDate()}'),
                            ),
                            ListTile(
                              title: Text('Código: ${estancia['code']}'),
                            ),
                            ListTile(
                            title: const Text('Eliminar estancia'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final bool result = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Eliminar estancia'),
                                    content: const Text('¿Estás seguro de que deseas eliminar esta estancia?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Sí'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('No'),
                                      ),
                                    ],
                                  );
                                },

                                ) ?? false;

                                if (result) {
                                  await eliminarEstancia(estancia['code']);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Estancia eliminada')),
                                  );
                                  _refreshListNotifier.value = !_refreshListNotifier.value; // Refrescar la lista
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}