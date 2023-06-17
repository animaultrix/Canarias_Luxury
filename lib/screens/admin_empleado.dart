import 'package:flutter/material.dart';


class AdminEmpleado extends StatelessWidget {
  const AdminEmpleado({super.key});
  static List<Map<String, String>> menu = [
    {'name': 'Ver empleados', 'route': '/admin_ver_empleados'},
    {'name': 'Crear empleado', 'route': '/admin_crear_empleado'},
    {'name': 'Borrar empleado', 'route': '/admin_borrar_empleado'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar empleado')),
      body: ListView.separated(
        itemCount: menu.length,
        itemBuilder: (context, i) => ListTile(
        title: Text(menu[i]['name']!),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),                
        onTap: () {              
          Navigator.pushNamed(context, menu[i]['route']!);
        },
      ),
      //_ para cuando no vaya usar argumento y __ para cuando tampoco vaya a usar el segundo argumento          
      separatorBuilder: (_, __) => const Divider(), 
      ),
   );
  }
}