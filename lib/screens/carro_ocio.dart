

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/widgeds/selector_estancia_fecha_ocio.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';



/**
 * Carro de la Ocio
 */
class CarroOcio extends StatefulWidget {
  const CarroOcio({Key? key}) : super(key: key);

  @override
  State<CarroOcio> createState() => _CarroState();
}

class _CarroState extends State<CarroOcio> {

  final ValueNotifier<DateTime?> selectedDateTimeNotifier =
      ValueNotifier<DateTime?>(null);
  final ValueNotifier<String> validationMessageNotifier = 
      ValueNotifier<String>('');
  final FirestoreEnviarPedido _firestoreEnviarPedido = FirestoreEnviarPedido();

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(title: Text(S.current.carro)),
      body: Consumer<OcioCartModel>(
        builder: (context, cart, child) {
          // Calcula el total
          double total = cart.total;

          // Obtiene la lista de items en el carrito
          List<Carrusel> items = cart.items;

          // Construye la lista de elementos del carrito
          List<Widget> cartItems = items.map<Widget>((item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item.nombre),
                Text("${item.precio.toString()}€"),
                GestureDetector(
                  onTap: () {
                    Provider.of<OcioCartModel>(context, listen: false).removeItem(item);
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 36.0,
                  ),
                ),
              ],
            );
          }).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: [
                  ...cartItems,
                  const SizedBox(height: 21),
                  Text("Total: ${total.toStringAsFixed(2)}€"),
                  const SizedBox(height: 21),
                  items.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(height: 21),
                            Text(S.current.mirarDescripccion),
                            const SizedBox(height: 13),
                            // Selector de fecha y hora
                            fechaSelector(context, selectedDateTimeNotifier, validationMessageNotifier),
                            const SizedBox(height: 8),

                            ValueListenableBuilder<DateTime?>(
                              valueListenable: selectedDateTimeNotifier,
                              builder: (context, selectedDateTime, child) {
                                return selectedDateTime == null
                                    ? const SizedBox.shrink()
                                    : Text(
                                        "${S.current.fechaSeleccionada}"
                                        "\n${DateFormat('yyyy-MM-dd').format(selectedDateTime)}",
                                      );
                              },
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable: validationMessageNotifier,
                              builder: (context, validationMessage, child) {
                                return validationMessage.isEmpty
                                    ? const SizedBox.shrink()
                                    : Text(
                                        validationMessage,
                                        style: const TextStyle(color: Colors.red),
                                      );
                              },
                            ),
                            const SizedBox(height: 21),
                            SizedBox(
                              width: double.infinity,
                              child: Builder(
                                builder: (buttonContext) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(S.current.confirmarPedido),
                                            content: Text(S.current.estaSeguroRealizarPago),
                                            actions: [
                                              TextButton(
                                                child: Text(S.current.cancelar),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(S.current.aceptar),
                                                onPressed: () async {
                                                  if (selectedDateTimeNotifier.value == null) {
                                                    validationMessageNotifier.value =
                                                        S.current.nofechahoraseleccionada;
                                                  } else {
                                                    validationMessageNotifier.value = '';
                                                    // Aquí puedes implementar la lógica de pago
                                                    // Obtén el code de la estancia
                                                    String code = Provider.of<UsuarioModel>(context, listen: false).code;
                                                    // Enviar el pedido a Firestore
                                                    await _firestoreEnviarPedido.enviarPedido(
                                                      fecha: selectedDateTimeNotifier.value!,
                                                      code: code,
                                                      items: cart.items,
                                                      total: cart.total,
                                                    ).then((_) {
                                                      // Muestra un mensaje de éxito
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(S.current.exitopedido),
                                                        ),
                                                      );
                                                      // Borra los ocios del carrito
                                                      Provider.of<OcioCartModel>(context, listen: false).clearCart();

                                                      // Cierra el AlertDialog y navega de regreso a la pantalla de la tienda
                                                      Navigator.of(context).pop(); // Cierra el AlertDialog
                                                      Navigator.of(context).pop(); // Navega de regreso a la pantalla de la tienda
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                    },

                                    child: Text(S.current.pagar),
                                  );
                                },
                              ),
                            )
                        ],
                      )
                      : Center(child: Text(S.current.nohaypedidos)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

