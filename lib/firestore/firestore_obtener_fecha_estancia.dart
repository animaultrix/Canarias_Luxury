import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<DocumentSnapshot> obtenerFechaEstancia(String code) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference estanciaDocRef = firestore.collection('estancia').doc(code);
  DocumentSnapshot estanciaSnapshot = await estanciaDocRef.get();
  return estanciaSnapshot;
}
