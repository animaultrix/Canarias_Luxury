import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/models/models.dart';

class EmpleadoPreEstancia extends StatefulWidget {
  const EmpleadoPreEstancia({super.key});

  @override
  State<EmpleadoPreEstancia> createState() => _EmpleadoPreEstanciaState();
}

class _EmpleadoPreEstanciaState extends State<EmpleadoPreEstancia> {
  Set<Marker> markers = {};
  int expandedIndex = -1;
  final FirestorePreEntrada _firestorePreEntrada = FirestorePreEntrada();

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      body: FutureBuilder<List<PreEstancia>>(
        future: _firestorePreEntrada.getEstanciasWithSalidaGreaterThanOrEqual(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PreEstancia> preEstancias = snapshot.data!;

            return ListView.separated(
              itemCount: preEstancias.length,
              itemBuilder: (context, i) {
                PreEstancia preEstancia = preEstancias[i];
                Servicio servicio = preEstancia.servicio;
                Estancia estancia = preEstancia.estancia;
                DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
                String entrada = dateFormat.format(estancia.entrada);
                String salida = dateFormat.format(estancia.salida);

                return FutureBuilder<Estancia>(
                  future: getEstanciaByCode(servicio.code),
                  builder: (context, estanciaSnapshot) {
                    if (estanciaSnapshot.hasData) {
                      Estancia estancia = estanciaSnapshot.data!;
                      return FutureBuilder<Vivienda>(
                        future: getViviendaById(estancia.idVivienda),
                        builder: (context, viviendaSnapshot) {
                          if (viviendaSnapshot.hasData) {
                            Vivienda vivienda = viviendaSnapshot.data!;
                            return ExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  expandedIndex = isExpanded ? -1 : i;
                                });
                              },
                              elevation: 1,
                              expandedHeaderPadding: const EdgeInsets.all(8.0),
                              children: [
                                
                                ExpansionPanel(
                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text('${vivienda.nombre}'),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Entrada: $entrada\n'
                                          'Recogida: ${servicio.recogida? "Sí" : "No"}'),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Salida: $salida\n'
                                          'Entrega: ${servicio.entrega? "Sí" : "No"}'),
                                      ),
                                      ListTile(
                                        title: Text('Cuna: ${servicio.cuna ? "Sí" : "No"}'),
                                      ),
                                      expandedIndex == i
                                          ? SizedBox(
                                              height: 200,
                                              child: GoogleMap(
                                                initialCameraPosition: getCameraPosition(
                                                    vivienda.latitud, vivienda.longitud),
                                                markers: {
                                                  createMarker(vivienda),
                                                },
                                                myLocationEnabled: true,
                                                myLocationButtonEnabled: true,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  isExpanded: expandedIndex == i,
                                ),
                              ],
                            );
                          } else if (viviendaSnapshot.hasError) {
                            return Text(
                                'Error al cargar la vivienda: ${viviendaSnapshot.error}');
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else if (estanciaSnapshot.hasError) {
                      return Text(
                          'Error al cargar la estancia: ${estanciaSnapshot.error}');
                    } else {
                      return Container();
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );

          } else if (snapshot.hasError) {
            return Text('Error al cargar los servicios: ${snapshot.error}');
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

  CameraPosition getCameraPosition(String lat, String lon) {
    return CameraPosition(
      target: LatLng(double.parse(lat), double.parse(lon)),
      zoom: 15,
    );
  }

  Marker createMarker(Vivienda vivienda) {
    return Marker(
      markerId: MarkerId(vivienda.id.toString()),
      position: LatLng(double.parse(vivienda.latitud), double.parse(vivienda.longitud)),
      infoWindow: InfoWindow(title: vivienda.nombre),
    );
  }

