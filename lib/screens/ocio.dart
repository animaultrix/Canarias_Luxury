import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class Ocio extends StatefulWidget {
  const Ocio({Key? key}) : super(key: key);

  @override
  _OcioState createState() => _OcioState();
}

class _OcioState extends State<Ocio> {
  late Future<List<Carrusel>> _carruselList;

  @override
  void initState() {
    super.initState();
    _carruselList = getImagenes(ocio: 'ocio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.ocio)),
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
                        child: CardImages(carruselImages: image, isOcio: true),
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
      floatingActionButton: Consumer<OcioCartModel>(
        builder: (context, cart, child) {
          var ocioCart = Provider.of<OcioCartModel>(context, listen: false);
          return ocioCart.total != 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/carro_ocio');
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
