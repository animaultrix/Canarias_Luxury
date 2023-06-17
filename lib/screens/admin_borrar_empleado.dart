import 'package:flutter/material.dart';


class AdminBorrarEmpleado extends StatelessWidget {
  const AdminBorrarEmpleado({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borrar empleado')),
      body: Center(
        child: Text('Borrar empleado'),
     ),
   );
  }
}