import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_dam/models/models.dart';
import 'dart:core';


class Producto {
  final String nombre;
  final String precio;
  final int cantidad;
  Producto({required this.nombre, required this.precio, required this.cantidad});
}



class Pedido {
  final String id;
  final String code;
  final Timestamp fecha;
  final List<Producto> pedidos;
  final double total;
  final double latitud;
  final double longitud;

  Pedido({
    required this.id,
    required this.code,
    required this.fecha,
    required this.pedidos,
    required this.total,
    required this.latitud,
    required this.longitud,
  });
}


Future<Estancia> getEstanciaByCode(String code) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('estancia')
      .where('code', isEqualTo: code)
      .get();

  if (snapshot.docs.isEmpty) {
    throw Exception("No se encontró ningún documento con el code $code en la colección 'estancia'");
  }

  final estanciaDoc = snapshot.docs.first;
  return Estancia.fromSnapshot(estanciaDoc);
}


Future<List<Pedido>> getPedidos() async {
  final pedidosRef = FirebaseFirestore.instance.collection('pedido');
  final estanciasRef = FirebaseFirestore.instance.collection('estancia');
  final viviendasRef = FirebaseFirestore.instance.collection('vivienda');

  List<Pedido> pedidos = [];

  QuerySnapshot querySnapshot = await pedidosRef.get();

  for (var pedidoDoc in querySnapshot.docs) {
    Map<String, dynamic> pedidoData = pedidoDoc.data() as Map<String, dynamic>;
    String code = pedidoData['code'];
    Timestamp fecha = pedidoData['fecha'];
    dynamic productosData = pedidoData['pedidos'];
    double total = pedidoData['total'];
    DateTime fechaPedido = fecha.toDate();
    DateTime now = DateTime.now();
    // Compara solo las fechas (ignorando la hora)
    int dateComparison = DateTime(fechaPedido.year, fechaPedido.month, fechaPedido.day)
        .compareTo(DateTime(now.year, now.month, now.day));
    Map<String, dynamic>? productosMap = {};
    // Si la fecha del pedido es igual o anterior a la fecha actual
    if (dateComparison >= 0) {
    List<Producto> productos = [];
    Map<String, Map<String, dynamic>> productosCount = {};

if (productosData is Map) {
  productosData.cast<String, dynamic>().forEach((nombre, precio) {
    if (productosCount.containsKey(nombre)) {
      productosCount[nombre]!['cantidad'] = (productosCount[nombre]!['cantidad'] ?? 0) + 1;
    } else {
      productosCount[nombre] = {'precio': precio, 'cantidad': 1};
    }
  });
} else if (productosData is List) {
  for (var producto in productosData) {
    if (producto is Map<String, dynamic>) {
      String nombre = producto['nombre'];
      String precio = producto['precio'];

      if (productosCount.containsKey(nombre)) {
        productosCount[nombre]!['cantidad'] = (productosCount[nombre]!['cantidad'] ?? 0) + 1;
      } else {
        productosCount[nombre] = {'precio': precio, 'cantidad': 1};
      }
    }
  }
}


productosCount.forEach((nombre, data) {
  productos.add(Producto(
    nombre: nombre,
    precio: data['precio'] as String,
    cantidad: data['cantidad'] as int,
  ));
});



    Estancia estancia = await getEstanciaByCode(code);


    QuerySnapshot viviendaSnapshot = await viviendasRef.get();
    for (var viviendaDoc in viviendaSnapshot.docs) {
      print("Documento: ${viviendaDoc.id}, Datos: ${viviendaDoc.data()}");
    }

    if (estancia != null) {
      int idVivienda = int.parse(estancia.idVivienda.toString());
     
      
     Vivienda vivienda = await getViviendaById(idVivienda.toString());

      print("vivienda: ${vivienda.toMap()}"); // Imprime los datos del objeto Vivienda


      double latitud = double.tryParse(vivienda.latitud) ?? 0.0;
      double longitud = double.tryParse(vivienda.longitud) ?? 0.0;


      Pedido pedido = Pedido(
          id: pedidoDoc.id,
          code: code,
          fecha: fecha,
          pedidos: productos,
          total: total,
          latitud: latitud,
          longitud: longitud);
      pedidos.add(pedido);
      }

      

    } else {
      print("El documento con el code $code no existe en la colección 'estancia'");
    }
  }

  return pedidos;
}

Future<LatLng> getCoordenadas(String code) async {
  final viviendasRef = FirebaseFirestore.instance.collection('vivienda');

  DocumentSnapshot? estanciaDoc = (await getEstanciaByCode(code)) as DocumentSnapshot<Object?>?;

  if (estanciaDoc == null) {
    throw Exception("No se encontró ningún documento con el code $code en la colección 'estancia'");
  }

  int idVivienda = int.parse(estanciaDoc['id'].toString());


  // Buscar el documento en la colección 'vivienda' según el valor del campo 'id'
  QuerySnapshot viviendaQuery = await viviendasRef.where('id', isEqualTo: idVivienda).get();
  if (viviendaQuery.docs.isEmpty) {
    throw Exception("El documento con id $idVivienda no existe en la colección 'vivienda'");
  }

  DocumentSnapshot viviendaDoc = viviendaQuery.docs.first;

  // Comprobar si el documento existe antes de acceder a sus campos
  if (!viviendaDoc.exists) {
    throw Exception("El documento con id $idVivienda no existe en la colección 'vivienda'");
  }

  String latitud = viviendaDoc['latitud'] ?? "0.0";
  String longitud = viviendaDoc['longitud'] ?? "0.0";

  return LatLng(double.parse(latitud), double.parse(longitud));
}

Future<Vivienda> getViviendaById(String id) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection('vivienda')
      .where('id', isEqualTo: int.parse(id))
      .get();

  if (query.docs.isEmpty) {
    throw Exception(
        "No se encontró ningún documento con el id $id en la colección 'vivienda'");
  }

  return Vivienda.fromSnapshot(query.docs.first);
}



































  /*
class Pedido {
  final String code;
  final Timestamp fecha;
  final List<Producto> pedidos;
  final String total;
  final String latitud;
  final String longitud;

  Pedido({required this.code, required this.fecha, required this.pedidos, required this.total, required this.latitud, required this.longitud});
}


Future<List<Map<String, dynamic>>> getPedidos() async {
  final pedidosRef = FirebaseFirestore.instance.collection('pedido');

  List<Map<String, dynamic>> pedidos = [];

  QuerySnapshot querySnapshot = await pedidosRef.get();

  for (var pedidoDoc in querySnapshot.docs) {
    Map<String, dynamic> pedidoData = pedidoDoc.data() as Map<String, dynamic>;
    String code = pedidoData['code'];
    Timestamp fecha = pedidoData['fecha'];
    dynamic productosData = pedidoData['pedidos'];
    double total = pedidoData['total'];

    Map<String, dynamic>? productosMap = {};

    if (productosData is Map) {
      productosMap = productosData.cast<String, dynamic>();
    } else if (productosData is List) {
      for (var producto in productosData) {
        if (producto is Map<String, dynamic>) {
          String nombre = producto['nombre'];
          String precio = producto['precio'];
          productosMap[nombre] = precio;
        }
      }
    }

    pedidos.add({
      'code': code,
      'fecha': fecha,
      'pedidos': productosMap,
      'total': total,
    });
  }

  return pedidos;
}*/