import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
//import 'package:proyecto_dam/generated/l10n.dart';
//import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/models/model_carrusel_admin.dart';
import 'package:proyecto_dam/widgeds/card_images_admin.dart';
//import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';


class AdminVerProductos extends StatefulWidget {
  const AdminVerProductos({super.key});

  @override
  State<AdminVerProductos> createState() => _AdminVerProductosState();
}

class _AdminVerProductosState extends State<AdminVerProductos> {
  late Future<List<Carrusel_admin>> _carruselList;
  @override
  void initState() {
    super.initState();
    _carruselList = getImagenesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ver tienda")),
      body: SingleChildScrollView(
        child: Column(
          children: [           
            FutureBuilder<List<Carrusel_admin>>(
              future: _carruselList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: snapshot.data!.map<Widget>((image) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 18, left: 18),
                        child: CardImagesAdmin(carruselImages: image),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<Carrusel_admin>(
        builder: (context, cart, child) {
          return cart.total != 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/carro');
                    },
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Total: \$${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "MulishM",
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink();
        },
      ),*/
    );
  }
}
