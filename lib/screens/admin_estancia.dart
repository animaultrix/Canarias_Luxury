import 'package:flutter/material.dart';


class AdminEstancia extends StatelessWidget {
  const AdminEstancia({super.key});
  static List<Map<String, String>> menu = [
    {'name': 'Ver estancia', 'route': '/admin_ver_estancia'},
    {'name': 'Crear estancia', 'route': '/admin_crear_estancia'},
    {'name': 'Borrar estancia', 'route': '/admin_borrar_estancia'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar estancia')),
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