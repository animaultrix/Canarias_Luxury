import 'package:flutter/material.dart';


class AdminCrearEmpleado extends StatelessWidget {
  const AdminCrearEmpleado({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear empleado')),
      body: Center(
        child: Text('Crear empleado'),
     ),
   );
  }
}