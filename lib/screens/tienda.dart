import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class Tienda extends StatefulWidget {
  const Tienda({Key? key}) : super(key: key);

  @override
  _TiendaState createState() => _TiendaState();
}

class _TiendaState extends State<Tienda> {
  late Future<List<Carrusel>> _carruselList;

  @override
  void initState() {
    super.initState();
    _carruselList = getImagenes(producto: 'producto');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.tienda)),
      body: SingleChildScrollView(
        child: Column(
          children: [           
            FutureBuilder<List<Carrusel>>(
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
                        child: CardImages(carruselImages: image),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<TiendaCartModel>(
        builder: (context, cart, child) {          
          var tiendaCart = Provider.of<TiendaCartModel>(context, listen: false);
          return tiendaCart.total != 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/carro');
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
      ),
    );
  }
}
