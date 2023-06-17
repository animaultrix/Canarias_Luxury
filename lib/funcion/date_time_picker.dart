import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


//selector de fechas

Future<DateTime?> showCustomDatePicker(
  BuildContext context, {
  required DateTime startDate,
  required DateTime endDate,
  
}) async {
  
  DateTime now = DateTime.now();
  DateTime initialDate = now.isBefore(startDate) ? startDate : now;

  if (initialDate.isAfter(endDate)) {
    // Si la fecha actual es posterior a la fecha de salida, no se puede seleccionar ninguna fecha
    return null;
  }
  print('Llamando a showDatePicker');
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: initialDate,
    lastDate: endDate,
  );

  return selectedDate;
}

//selector de horas
Future<int?> showCustomHoursPicker(BuildContext context, DateTime selectedDate) async {
  int startHour = 12;
  int endHour = 20;
  int currentHour = DateTime.now().hour;
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  // Si la fecha seleccionada es hoy, ajusta la hora de inicio según la hora actual
  if (isSameDay(selectedDate, DateTime.now())) {
    startHour = (currentHour + 1 > startHour) ? currentHour + 1 : startHour;
  }

  List<int> hourList = List<int>.generate(endHour - startHour + 1, (index) => startHour + index);
  print('Llamando a showModalBottomSheet');
  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Seleccionar hora'),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: hourList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${hourList[index]}:00'),
                  onTap: () {
                    Navigator.pop(context, hourList[index]);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}



//obtener horas disponibles
List<int> getAvailableHours(DateTime selectedDate, DateTime currentDate) {
  List<int> availableHours = [];

  int startHour = 12;
  int endHour = 20;

  if (selectedDate.year == currentDate.year &&
      selectedDate.month == currentDate.month &&
      selectedDate.day == currentDate.day) {
    startHour = max(currentDate.hour + 1, startHour);
  }

  for (int i = startHour; i <= endHour; i++) {
    availableHours.add(i);
  }

  return availableHours;
}
