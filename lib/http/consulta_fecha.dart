import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<DateTime> getCurrentTimeInCanarias({int retries = 3}) async {
  for (int i = 0; i < retries; i++) {
    try {
      print(i);
      final response = await http.get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Atlantic/Canary'));
      if (response.statusCode == 200) {
        final dynamic responseJson = jsonDecode(response.body);
        final String dateString = responseJson['datetime'];
        final String formattedDateString = dateString.substring(0, 23) + 'Z';
        DateTime dateTime = DateTime.parse(formattedDateString);
        print("dateTime: $dateTime");
        return dateTime;
      } else {
        throw Exception('Error fetching current time in Canary Islands');
      }
    } catch (e) {
      if (i == retries - 1) {
        print('Error fetching current time in Canary Islands: $e');
        //DateTime localDateTime = DateTime.now();
        // print('localDateTime: $localDateTime');
        //return localDateTime;
      } else {
        await Future.delayed(Duration(milliseconds: 500));
      }
    }
  }
  // Añade una declaración de retorno para evitar el error de 'null' en el tipo de retorno
  throw Exception(
      'Error fetching current time in Canary Islands after maximum retries');
}
