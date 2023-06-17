import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore_pre_estancia.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/theme/app_theme.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class PreEntrada extends StatefulWidget {
  const PreEntrada({super.key});

  @override
  _PreEntradaState createState() => _PreEntradaState();
}

class _PreEntradaState extends State<PreEntrada> {
  bool recogidaAeropuerto = false;
  bool entregaAeropuerto = false;
  bool solicitaCuna = false;
  bool recogidaAeropuertoInicial = false;
  bool entregaAeropuertoInicial = false;
  bool solicitaCunaInicial = false;
  final FirestorePreEntrada _firestorePreEntrada = FirestorePreEntrada();
  DocumentSnapshot<Map<String, dynamic>>? _servicio;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cargarServicio();
    });
  }

  Future<void> cargarServicio() async {
  final userModel = Provider.of<UsuarioModel>(context, listen: false);
  final String code = userModel.code;
  final servicio = await _firestorePreEntrada.obtenerServicio(code);
  if (servicio.exists) {
    print("Datos cargados desde Firestore: ${servicio.data()}");
    setState(() {
      _servicio = servicio;
      recogidaAeropuerto = servicio.data()?['recogida'] ?? false;
      entregaAeropuerto = servicio.data()?['entrega'] ?? false;
      solicitaCuna = servicio.data()?['cuna'] ?? false;

      // Almacenar el estado inicial
      recogidaAeropuertoInicial = recogidaAeropuerto;
      entregaAeropuertoInicial = entregaAeropuerto;
      solicitaCunaInicial = solicitaCuna;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UsuarioModel>(context);
    final String code = userModel.code;

    double cantidad1 = 30;
    double cantidad2 = 30;
    double cantidad3 = 0;
    double total = 0;

    total += ((!recogidaAeropuertoInicial && recogidaAeropuerto) || (recogidaAeropuertoInicial && !recogidaAeropuerto)) ? cantidad1 : 0;
    total += ((!entregaAeropuertoInicial && entregaAeropuerto) || (entregaAeropuertoInicial && !entregaAeropuerto)) ? cantidad2 : 0;
    total += ((!solicitaCunaInicial && solicitaCuna) || (solicitaCunaInicial && !solicitaCuna)) ? cantidad3 : 0;

    return Scaffold(
      appBar: AppBar(title: Text(S.current.preEntrada)),
      body: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recogida en el aeropuerto ($cantidad1€): "),
                // Recogida en el aeropuerto
                Checkbox(
                  value: recogidaAeropuerto,
                  onChanged: (_servicio == null || !(_servicio?.data()?['recogida'] ?? false))
                      ? (bool? newValue) {
                          setState(() {
                            recogidaAeropuerto = newValue ?? false;
                          });
                        }
                      : null,
                  activeColor: AppTheme.dorado,
                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return AppTheme.dorado;
                    }
                    return Colors.grey;
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Entrega en el aeropuerto ($cantidad2€): "),
                // Entrega en el aeropuerto
                Checkbox(
                  value: entregaAeropuerto,
                  onChanged: (_servicio == null || !(_servicio?.data()?['entrega'] ?? false))
                      ? (bool? newValue) {
                          setState(() {
                            entregaAeropuerto = newValue ?? false;
                          });
                        }
                      : null,
                  activeColor: AppTheme.dorado,
                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return AppTheme.dorado;
                    }
                    return Colors.grey;
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Solicita cuna ($cantidad3€): "),
                // Solicita cuna
                Checkbox(
                  value: solicitaCuna,
                  onChanged: (_servicio == null || !(_servicio?.data()?['cuna'] ?? false))
                      ? (bool? newValue) {
                          setState(() {
                            solicitaCuna = newValue ?? false;
                          });
                        }
                      : null,
                  activeColor: AppTheme.dorado,
                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    if (states.contains(MaterialState.selected)) {
                      return AppTheme.dorado;
                    }
                    return Colors.grey;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${S.current.total}: "),
                Text("$total€"),
              ],
            ),
            const SizedBox(height: 18,),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(child: Texto(texto: S.current.estasSeguro, tamano: 15, margenes: const EdgeInsets.only(top:0,left: 0,right: 0))),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Texto(texto:"${S.current.total}: $total€", tamano: 15,fontWeight: FontWeight.bold, margenes: const EdgeInsets.only(top:8,left: 0,right: 0)),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(S.current.cancelar),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(S.current.aceptar),
                          onPressed: () async {
                            await _firestorePreEntrada.guardarServicio(
                              code,
                              recogidaAeropuerto,
                              entregaAeropuerto,
                              solicitaCuna,
                            );
                            Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                            Navigator.of(context).pop(); // Regresa a la pantalla anterior
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(S.current.pagar),
            ),
          ],
        ),
      ),
    );
  }
}

