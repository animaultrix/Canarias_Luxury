import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

  Future<DateTime> getCurrentTimeInCanarias() async {
    final response = await http.get(Uri.parse('https://worldtimeapi.org/api/timezone/Atlantic/Canary'));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final dateString = responseJson['datetime'];
      return DateTime.parse(dateString);
    } else {
      throw Exception('Failed to load current time');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<DateTime>(
          future: getCurrentTimeInCanarias(),
          builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
            if (snapshot.hasData) {
              return Text('Fecha actual en Canarias: ${snapshot.data!.toString()}',
                  style: TextStyle(fontSize: 24.0));
            } else if (snapshot.hasError) {
              return Text('Error al cargar la fecha actual');
            } else {
              return Text('Cargando...');
            }
          },
        ),
      ),
    );
  }
}
