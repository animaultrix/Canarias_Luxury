import 'package:flutter/material.dart';

import '../router/app_routes.dart';


class EmpleadoMenu extends StatelessWidget {
  const EmpleadoMenu({super.key});


  @override
  Widget build(BuildContext context) {
    final menuOption = AppRoutes.menuOptionsEmpleado;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Empleado')),
        body: ListView.separated(
          itemCount: menuOption.length,
          itemBuilder: (context, i) => ListTile(
                title: Text(menuOption[i].name),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),                
                onTap: () {              
                  Navigator.pushNamed(context, menuOption[i].route);
                },
              ),
          //_ para cuando no vaya usar argumento y __ para cuando tampoco vaya a usar el segundo argumento          
          separatorBuilder: (_, __) => const Divider(), 
        ),
   );
  }
}