import 'package:flutter/material.dart';

class Texto extends StatelessWidget {

  final String texto;
  final double tamano;
  FontWeight fontWeight;
  EdgeInsets margenes;

  Texto({
    Key? key, 
    required this.texto, 
    required this.tamano, 
    this.fontWeight = FontWeight.normal,
    this.margenes = const EdgeInsets.only(top:30,left: 50,right: 50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margenes,
      child: Text(
        texto,
        style: TextStyle(
          color: const Color.fromARGB(255, 109, 109, 109), 
          fontSize: tamano,
          fontWeight: fontWeight          
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}