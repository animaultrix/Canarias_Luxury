import 'package:flutter/material.dart';


class AdminOcio extends StatelessWidget {
  const AdminOcio({super.key});
  static List<Map<String, String>> menu = [
    {'name': 'Ver ocios', 'route': '/admin_ver_ocios'},
    {'name': 'Crear ocio', 'route': '/admin_crear_ocio'},
    {'name': 'Borrar ocio', 'route': '/admin_borrar_ocio'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar ocio')),
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