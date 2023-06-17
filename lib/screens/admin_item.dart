import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:proyecto_dam/models/model_carrusel_admin.dart';
import 'package:proyecto_dam/models/model_cart.dart';
import 'package:proyecto_dam/screens/tienda.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';


class ItemAmin extends StatefulWidget {

  final Carrusel_admin carruselImages;
  
  const ItemAmin({Key? key, 

  required this.carruselImages
  
  }) : super(key: key);

  @override
  State<ItemAmin> createState() => _ItemState();
}


class _ItemState extends State<ItemAmin> {
  int quantity = 1;

  void onQuantityChanged(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          foregroundColor: const Color.fromARGB(255, 109, 109, 109),
          title: Text(
            widget.carruselImages.nombre,            
            style: TextStyle(
              color: const Color.fromARGB(255, 109, 109, 109),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: FadeInImage(
                    placeholder: NetworkImage("assets/loading.gif"),
                    image: NetworkImage(widget.carruselImages.imagen),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texto(
                      texto: widget.carruselImages.descripcion, 
                      tamano: 13
                    ),
                    const SizedBox(height: 18),

                    Texto(
                      texto: "${widget.carruselImages.precio} €", 
                      tamano: 18
                    ),
                    SizedBox(height: 18,),
                    Counter(
                      initialValue: quantity,
                      onChanged: onQuantityChanged,
                    ),
                    //Boton(texto: S.current.aniadir, item: widget.carruselImages, quantity: quantity),
                  ]
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
/*.................

Texto

''''''''''''''''''*/
class Texto extends StatelessWidget {

  final String texto;
  final double tamano;

  const Texto({
    Key? key, 
    required this.texto, 
    required this.tamano,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 21),
      child: Text(
        texto,
        style: TextStyle(
         fontFamily: 'MulishM',
         color: const Color.fromARGB(255, 109, 109, 109), 
         fontSize: tamano,         
        ),
        textAlign: TextAlign.justify,
      ),      
    );
  }
}
/*.................

Boton

''''''''''''''''''*//*
class Boton extends StatelessWidget {

  final String texto;
  final Carrusel item;
  final int quantity;

  const Boton({
    Key? key, 
    required this.texto,
    required this.item,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18, left: 50, right: 50),             
      child: ElevatedButton(
        child:  Text(texto),
        onPressed: () {
          Provider.of<CartModel>(context, listen: false).addItem(item, quantity);
          // Elimina todas las pantallas de la pila de navegación y agrega Menu y Tienda
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Tienda(),
            ),
            ModalRoute.withName('/menu'),
          );
        }
      )
    );
  }
}*/