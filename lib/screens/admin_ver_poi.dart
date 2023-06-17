import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminVerPOI extends StatefulWidget {
  const AdminVerPOI({Key? key}) : super(key: key);

  @override
  _AdminVerPOIState createState() => _AdminVerPOIState();
}

class _AdminVerPOIState extends State<AdminVerPOI> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Set<Marker> _markers = {};

  List<bool> isExpandedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver POI'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('poi').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> poiDocs = snapshot.data!.docs;

            if (isExpandedList.length != poiDocs.length) {
              isExpandedList = List.generate(poiDocs.length, (_) => false);
            }

            return ListView.builder(
              itemCount: poiDocs.length,
              itemBuilder: (context, i) {
                Map<String, dynamic> poiData = poiDocs[i].data() as Map<String, dynamic>;
                String id = poiDocs[i].id;
                bool isExpanded = isExpandedList[i];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpandedList[i]) {
                            isExpandedList[i] = false;
                            _markers.clear();
                          } else {
                            for (int j = 0; j < isExpandedList.length; j++) {
                              if (j != i) {
                                isExpandedList[j] = false;
                              }
                            }
                            isExpandedList[i] = true;
                            _addMarker(i, poiDocs);
                          }
                        });
                      },
                      child: ListTile(
                        title: Text(poiData['nombre']),
                        trailing: Icon(isExpanded ? Icons.expand_less_outlined : Icons.expand_more_outlined),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: isExpanded ? 250 : 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(poiData['info']),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              height: 200,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(poiData['latitud'] as String),
                                    double.parse(poiData['longitud'] as String),
                                  ),
                                  zoom: 15,
                                ),
                                markers: _markers,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al obtener los datos de la base de datos'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _addMarker(int i, List<QueryDocumentSnapshot> poiDocs) {
    Map<String, dynamic> poiData = poiDocs[i].data() as Map<String, dynamic>;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(poiData['nombre']),
          position: LatLng(
            double.parse(poiData['latitud'] as String),
            double.parse(poiData['longitud'] as String),
          ),
          infoWindow: InfoWindow(title: poiData['nombre']),
        ),
      );
    });
  }
}
