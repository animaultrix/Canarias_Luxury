import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/firestore/firestore_pedido_empleado.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class MiEstancia extends StatefulWidget {
  const MiEstancia({Key? key}) : super(key: key);

  @override
  State<MiEstancia> createState() => _MiEstanciaState();
}

class _MiEstanciaState extends State<MiEstancia> {
  int expandedIndex = -1;
  int cantidad = 0;

  String formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeFormat = DateFormat("HH:mm");
    String formattedDate = dateFormat.format(dateTime);
    String formattedTime = timeFormat.format(dateTime);
    return "$formattedDate${dateTime.hour != 0 || dateTime.minute != 0 ? ' $formattedTime' : ''}";
  }


  @override
Widget build(BuildContext context) {
  final String code = Provider.of<UsuarioModel>(context).code;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.miStancia),
      ),
      body: FutureBuilder<List<Pedido>>(
        future: getPedidosByCode(code),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pedido> pedidos = snapshot.data!;
            if (pedidos.isEmpty) {
        // Muestra un mensaje personalizado cuando no hay productos
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Icon( Icons.production_quantity_limits_outlined, size: 88, color: Colors.grey,)),
                Texto(texto: S.current.nohaypedidos, tamano: 16),
              ],
            );
            }else {
             // Muestra la lista de pedidos cuando hay productos
            return ListView.separated(              
              itemCount: pedidos.length,
              itemBuilder: (context, i) {
                Pedido pedido = pedidos[i];
                return FutureBuilder<Estancia>(
                  future: getEstanciaByCode(pedido.code),
                  builder: (context, estanciaSnapshot) {
                    if (estanciaSnapshot.hasData) {
                      Estancia estancia = estanciaSnapshot.data!;
                      return FutureBuilder<Vivienda>(
                        future: getViviendaById(estancia.idVivienda),
                        builder: (context, viviendaSnapshot) {
                          if (viviendaSnapshot.hasData) {
                            Vivienda vivienda = viviendaSnapshot.data!;
                            return ExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  expandedIndex = isExpanded ? -1 : i;
                                });
                              },
                              elevation: 0,
                              expandedHeaderPadding: const EdgeInsets.all(8.0),
                              children: [
                                ExpansionPanel(
                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                    
                                    return ListTile(
                                      title: Text('${S.current.pedido}: ${i+1}'),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      Column(
                                        children: pedido.pedidos.map((producto) {
                                          return ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('${producto.cantidad}x ${producto.nombre}',                                                  
                                                    style: const TextStyle(fontSize: 16)
                                                  ),
                                                ),
                                                Text(
                                                  '${producto.precio} €',
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('(${formatDateTime(pedido.fecha)})\n'),
                                            Text('Total: ${pedido.total}€',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  isExpanded: expandedIndex == i,
                                ),
                              ],
                            );
                          } else if (viviendaSnapshot.hasError) {
                            return Text(
                                'Error al cargar la vivienda: ${viviendaSnapshot.error}');
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else if (estanciaSnapshot.hasError) {
                      return Text(
                          'Error al cargar la estancia: ${estanciaSnapshot.error}');
                    } else {
                      return Container();
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
        } else if (snapshot.hasError) {
          return Text('Error al cargar los pedidos: ${snapshot.error}');
        } else {          
         return Center(
              child: Image.asset(
                'assets/loading.gif',
                width: 100,
                height: 100,
              ),
            );
        }
      },
    ),
  );
}
}
Future<List<Pedido>> getPedidosByCode(String code) async {
  List<Pedido> allPedidos = await getPedidos();
  List<Pedido> filteredPedidos = allPedidos.where((pedido) => pedido.code == code).toList();
  return filteredPedidos;
}
