import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_dam/firestore/firestore_ver_viviendas.dart';

class AdminVerViviendas extends StatefulWidget {
  const AdminVerViviendas({super.key});

  @override
  State<AdminVerViviendas> createState() => _AdminVerViviendasState();
}

class _AdminVerViviendasState extends State<AdminVerViviendas> {
  // Lista de viviendas
  Future<List<Map<String, dynamic>>>? viviendas;

  // Lista de estados de expansión para cada elemento en la lista
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    viviendas = getViviendas();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition getCameraPosition(int i, List<Map<String, dynamic>> viviendas) {
      return CameraPosition(
        target: LatLng(
          double.parse(viviendas[i]['latitud'] as String),
          double.parse(viviendas[i]['longitud'] as String),
        ),
        zoom: 15,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viviendas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: viviendas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> viviendas = snapshot.data!;
            // Actualizar la lista de estados de expansión
            if (isExpandedList.length != viviendas.length) {
              isExpandedList = List.generate(viviendas.length, (_) => false);
            }
            return ListView.builder(
              itemCount: viviendas.length,
              itemBuilder: (context, i) {
                bool isExpanded = isExpandedList[i];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpandedList[i]) {
                            // Si ya está expandido, cerrar este elemento
                            isExpandedList[i] = false;
                          } else {
                            // Si se abre el elemento, cerrar los demás
                            for (int j = 0; j < isExpandedList.length; j++) {
                              if (j != i) {
                                isExpandedList[j] = false;
                              }
                            }
                            // Abrir este elemento
                            isExpandedList[i] = true;
                          }
                        });
                      },
                      child: ListTile(
                        title: Text(viviendas[i]['nombre']!),
                        trailing: Icon(isExpanded ? Icons.expand_more_outlined : Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: isExpanded ? 250 : 0, // Modificar la altura para que entre el texto y el mapa
                      child: SingleChildScrollView( // Añadir SingleChildScrollView
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(31.0),
                              child: Text(viviendas[i]['info']!,),
                            ),
                            SizedBox(height: 5), // Añadir espacio entre el texto y el mapa
                            Container(
                              height: 200,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: getCameraPosition(i, viviendas),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), // Añadir el divisor aquí, ya que ListView.builder() no tiene un separador incorporado
                    const Divider(), // Añadir el divisor aquí, ya que ListView.builder() no tiene un separador incorporado
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al obtener los datos de la base de datos'));
          } else {
            return Center(
              child: Image.asset(
                'assets/loading.gif',
                width: 100,
                height: 100,
              ),
            );
          }
        },
      ),
    );
  }
}
