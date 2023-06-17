import 'package:flutter/material.dart';

import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/screens/item.dart';
import 'package:proyecto_dam/screens/item_ocio.dart';

class MenuCardImages extends StatelessWidget {
  final Carrusel carruselImages;

  const MenuCardImages({
    Key? key,
    required this.carruselImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            print("tipo: "+carruselImages.tipo);
            if (carruselImages.tipo == 'producto') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Item(carruselImages: carruselImages),
                ),
              );
            } else if (carruselImages.tipo == 'ocio') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemOcio(carruselImages: carruselImages),
                ),
              );
            }
          },
          child: Image.network(
            carruselImages.imagen,
            fit: BoxFit.cover,
            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                return child;
              }
              return Center(
                child: SizedBox(
                  height: double.infinity, // Ajusta la altura según sea necesario
                  child: Image.asset("assets/loading.gif"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
