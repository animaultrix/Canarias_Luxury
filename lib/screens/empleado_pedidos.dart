import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/models/models.dart';

class EmpleadoPedidos extends StatefulWidget {
  const EmpleadoPedidos({super.key});

  @override
  State<EmpleadoPedidos> createState() => _EmpleadoPedidosState();
}

class _EmpleadoPedidosState extends State<EmpleadoPedidos> {
  Set<Marker> markers = {};
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda y ocio'),
      ),
      body: FutureBuilder<List<Pedido>>(
        future: getPedidos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pedido> pedidos = snapshot.data!;

            return ListView.separated(
              itemCount: pedidos.length,
              itemBuilder: (context, i) {
                Pedido pedido = pedidos[i];
                int timestamp = pedido.fecha.millisecondsSinceEpoch;
                DateTime fechaHora = DateTime.fromMillisecondsSinceEpoch(timestamp);
                String fechaHoraStr = '${fechaHora.day.toString().padLeft(2, '0')}/${fechaHora.month.toString().padLeft(2, '0')}/${fechaHora.year} ${fechaHora.hour.toString().padLeft(2, '0')}:${fechaHora.minute.toString().padLeft(2, '0')}';
                return FutureBuilder<Estancia>(
                  future: getEstanciaByCode(pedido.code),
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
                                      title: Text('Pedido de ${vivienda.nombre}'),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      Column(
                                        children: pedido.pedidos.map((producto) {
                                          return ListTile(
                                            title: Text(
                                                '${producto.cantidad}x ${producto.nombre} ${producto.precio} €'),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          fechaHoraStr,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Total: ${pedido.total}€',
                                          style: const TextStyle(fontSize: 16),
                                        ),
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
          return Text('Error al cargar los pedidos: ${snapshot.error}');
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
}
