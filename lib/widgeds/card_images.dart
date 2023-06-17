import 'package:flutter/material.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/screens/item.dart';
import 'package:proyecto_dam/screens/item_ocio.dart';

class CardImages extends StatefulWidget {  

  final Carrusel carruselImages;
  final bool isOcio;
  final bool disableAddButton;

  const CardImages({
    Key? key,

    required this.carruselImages,
    this.isOcio = false,  
    this.disableAddButton = false,

  }) : super(key: key);

  @override
  State<CardImages> createState() => _CardImagesState();
}

class _CardImagesState extends State<CardImages> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            widget.carruselImages.copy();
            if (widget.isOcio) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemOcio(carruselImages: widget.carruselImages, disableAddButton: widget.disableAddButton),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Item(carruselImages: widget.carruselImages),
                ),
              );
            }
          },
          child: FadeInImage(
            placeholder: const AssetImage("assets/loading.gif"),
            image: NetworkImage(widget.carruselImages.imagen),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
