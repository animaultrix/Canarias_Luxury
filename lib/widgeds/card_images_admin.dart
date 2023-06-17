import 'package:flutter/material.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/models/model_carrusel_admin.dart';
import 'package:proyecto_dam/screens/admin_item.dart';
import 'package:proyecto_dam/screens/item.dart';

class CardImagesAdmin extends StatefulWidget {  

  final Carrusel_admin carruselImages;

  const CardImagesAdmin({
    Key? key,

    required this.carruselImages, 

  }) : super(key: key);

  @override
  State<CardImagesAdmin> createState() => _CardImagesState();
}

class _CardImagesState extends State<CardImagesAdmin> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: (){
            widget.carruselImages.copy();
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ItemAmin(carruselImages:  widget.carruselImages)
              )
            );
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
