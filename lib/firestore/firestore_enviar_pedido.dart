import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_dam/models/models.dart';

class FirestoreEnviarPedido {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> enviarPedido(
      {required DateTime fecha,
      required String code,
      required List<Carrusel> items,
      required double total}) async {
    CollectionReference pedidos = _firestore.collection('pedido');

    Map<String, dynamic> pedidoData = {
      'fecha': Timestamp.fromDate(fecha),
      'code': code,
      'total': total,
      'pedidos': items.map((item) => {
            'nombre': item.nombre,
            'precio': item.precio,
          }).toList(),
    };

    await pedidos.add(pedidoData);
  }
}
