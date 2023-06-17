import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/funcion/funcion.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_usuario.dart';

Widget fechaSelector(BuildContext context, ValueNotifier<DateTime?> selectedDateTimeNotifier, ValueNotifier<String> validationMessageNotifier) {
  return Consumer<UsuarioModel>(
    builder: (context, usuarioModel, child) {
      String code = usuarioModel.code;

      return FutureBuilder<DocumentSnapshot>(
        future: obtenerFechaEstancia(code),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> estanciaData = snapshot.data!.data() as Map<String, dynamic>;
              DateTime entrada = DateTime.fromMillisecondsSinceEpoch(estanciaData['entrada'].millisecondsSinceEpoch);
              DateTime salida = DateTime.fromMillisecondsSinceEpoch(estanciaData['salida'].millisecondsSinceEpoch);

              // Aquí puedes utilizar showCustomDatePicker sin la hora
              return ElevatedButton(
                onPressed: () async {
                  DateTime? selectedDate = await showCustomDatePicker(
                    context,
                    startDate: entrada,
                    endDate: salida,
                  );

                  if (selectedDate != null) {
                    // Actualiza la fecha seleccionada
                    selectedDateTimeNotifier.value = selectedDate;
                    validationMessageNotifier.value = '';
                  }
                },
                child: Text(S.current.selecionfecha),
              );

            } else {
              // Manejar el caso en que el documento no existe.
              return Text('Estancia no encontrada');
            }
          } else {
            // Muestra un indicador de carga mientras se obtienen los datos de la estancia.
            return CircularProgressIndicator();
          }
        },
      );
    },
  );
}
