import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_dam/firestore/firestore.dart';


class AdminVerEstancia extends StatelessWidget {
  const AdminVerEstancia({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> obtenerNombresViviendas() async {
    List<Map<String, dynamic>> viviendas = await getViviendas();
    List<Map<String, dynamic>> nombresViviendas = [];
    for (var vivienda in viviendas) {
      String idVivienda = vivienda['id'].toString();
      String nombreVivienda = vivienda['nombre'];
      nombresViviendas.add({'id': idVivienda, 'nombre': nombreVivienda});
    }
    return nombresViviendas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ver estancia')),
      body: FutureBuilder<List<List<Map<String, dynamic>>>>(
        future: Future.wait([
          obtenerEstanciasConFechaSalidaSuperior(),
          obtenerNombresViviendas(),
        ]),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final estancias = snapshot.data![0];
            final nombresViviendas = snapshot.data![1];
            return ListView.builder(
              itemCount: estancias.length,
              itemBuilder: (BuildContext context, int index) {                
                final estancia = estancias[index];
                DateFormat format = DateFormat('yyyy-MM-dd HH:mm'); // Formato: año-mes-día hora:minuto
                String formattedEntrada = format.format(estancia['entrada'].toDate());
                String formattedSalida = format.format(estancia['salida'].toDate());
                String idVivienda = estancia['id_vivienda'].toString();
                String nombreVivienda = nombresViviendas.firstWhere((vivienda) => vivienda['id'] == idVivienda, orElse: () => {'nombre': 'Desconocido'})['nombre'];
                return ExpansionTile(
                  title: Text('Vivienda: $nombreVivienda'),
                  children: [
                    ListTile(
                      title: Text('Mail: ${estancia['mail']}'),
                    ),
                    ListTile(
                      title: Text('Fecha de entrada: $formattedEntrada'),
                    ),
                    ListTile(
                      title: Text('Fecha de salida: $formattedSalida'),
                    ),
                    ListTile(
                      title: Text('Código: ${estancia['code']}'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}