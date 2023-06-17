import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<List<Carrusel>> _carruselList;

  @override
  void initState() {
    super.initState();
    _carruselList = getImagenes(producto: 'producto', ocio: 'ocio');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/menu_usuario');
                  },
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xffac862e),
                    size: 36.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 48, right: 8),
                )
              ],
            ),
            Expanded(child: Container()),
            FutureBuilder<List<Carrusel>>(
              future: _carruselList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CarouselSlider.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (contex, index, realIndex) {
                      final carruselImage = snapshot.data?[index];
                      if (carruselImage != null) {
                        return MenuCardImages(carruselImages: carruselImage);
                      } else {
                        return SizedBox
                            .shrink(); // Devuelve un widget vacío si carruselImage es nulo
                      }
                    },//
                    options: CarouselOptions(
                      viewportFraction: 0.8,
                      aspectRatio: 2.0,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 8),
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }
              },
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Boton(texto: S.current.miStancia, navigator: "/mi_estancia"),
                Boton(texto: S.current.tienda, navigator: "/tienda"),
                Boton(texto: S.current.ocio, navigator: "/ocio"),
                Boton(texto: S.current.puntoInteres, navigator: "/poi"),
                Container(
                  height: 32,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*.................

Boton

''''''''''''''''''*/
class Boton extends StatelessWidget {
  final String texto;
  final String navigator;
  const Boton({
    Key? key,
    required this.texto,
    required this.navigator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 13, left: 50, right: 50),
        child: ElevatedButton(
            child: Text(texto),
            onPressed: () {
              Navigator.pushNamed(context, navigator);
            }));
  }
}
