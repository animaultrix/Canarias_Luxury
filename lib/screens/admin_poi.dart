import 'package:flutter/material.dart';


class AdminPOI extends StatelessWidget {
  const AdminPOI({super.key});
  static List<Map<String, String>> menu = [
    {'name': 'Ver POI', 'route': '/admin_ver_poi'},
    {'name': 'Crear POI', 'route': '/admin_crear_poi'},
    {'name': 'Borrar POI', 'route': '/admin_borrar_poi'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar POI')),
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