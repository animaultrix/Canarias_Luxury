import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/funcion/funcion.dart';

import '../generated/l10n.dart';


class Poi extends StatefulWidget {
  const Poi({super.key});

  @override
  State<Poi> createState() => _PoiState();
}

class _PoiState extends State<Poi> {
  
  Future<List<Map<String, dynamic>>>? poi;
  Set<Marker> _markers = {};

  double centerLat = 0;
  double centerLon = 0; 


  // Lista de estados de expansión para cada elemento en la lista
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    // Llama a getViviendaCoordinates y luego a getPOI con las coordenadas de la vivienda
    
    getViviendaCoordinates(context).then((coordinates) {
      print('initState - Coordenadas: ${coordinates[0]}, ${coordinates[1]}');
      setState(() {
      centerLat = coordinates[0];
      centerLon = coordinates[1];
    });
      poi = getPOI(coordinates[0], coordinates[1]);      
    });
  }


  @override
  Widget build(BuildContext context) {
    CameraPosition getCameraPosition(int i, List<Map<String, dynamic>> poi) {
      return CameraPosition(
        target: LatLng(
          double.parse(poi[i]['latitud'] as String),
          double.parse(poi[i]['longitud'] as String),
        ),
        zoom: 15,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.poi),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
       
        future: poi,
        builder: (context, snapshot) {
           print("entra en builder");
          if (snapshot.hasData) {
            print("entra en primer if");
            List<Map<String, dynamic>> poi = snapshot.data!;

            // Coordenadas de la ubicación central (reemplaza estos valores con las coordenadas deseadas)
            
            double radius = 5; // Radio en kilómetros

            // Filtrar los POIs dentro del radio de 5 km
            List<Map<String, dynamic>> filteredPoi = [];
            for (var p in poi) {
              double lat = double.parse(p['latitud'] as String);
              double lon = double.parse(p['longitud'] as String);
              double distance = calculateDistance(centerLat, centerLon, lat, lon);
              print("c: $centerLat, centerLon: $centerLon");
              print("Distancia al POI ${p['nombre']}: $distance km");
              if (distance <= radius) {
                filteredPoi.add(p);
              }
            }
            print("POIs antes de filtrar: ${poi.length}");
            poi = filteredPoi;
            print("POIs después de filtrar: ${poi.length}");




            // Actualizar la lista de estados de expansión
            if (isExpandedList.length != poi.length) {
              isExpandedList = List.generate(poi.length, (_) => false);
            }
            return ListView.builder(
              itemCount: poi.length,
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
                            _markers.clear();
                          } else {
                            // Si se abre el elemento, cerrar los demás
                            for (int j = 0; j < isExpandedList.length; j++) {
                              if (j != i) {
                                isExpandedList[j] = false;
                              }
                            }
                            // Abrir este elemento
                            isExpandedList[i] = true;
                            _addMarker(i, poi);
                          }
                        });
                      },
                      child: ListTile(
                        title: Text(poi[i]['nombre']!),
                        trailing: Icon(isExpanded ?  Icons.expand_less_outlined :Icons.expand_more_outlined),
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
                              child: Text(poi[i]['info']!,),
                            ),
                            SizedBox(height: 5), // Añadir espacio entre el texto y el mapa
                            SizedBox(
                              height: 200,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: getCameraPosition(i, poi),
                                markers: _markers,
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
            return const Center(child: Text('Error al obtener los datos de la base de datos'));
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
  void _addMarker(int i, List<Map<String, dynamic>> poi) {
  setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId(poi[i]['nombre']),
        position: LatLng(
          double.parse(poi[i]['latitud'] as String),
          double.parse(poi[i]['longitud'] as String),
        ),
        infoWindow: InfoWindow(title: poi[i]['nombre']),
      ),
    );
  });
}

}