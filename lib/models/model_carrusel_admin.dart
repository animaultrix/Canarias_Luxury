class Carrusel_admin {
  final int id;
  final String nombre;
  final String imagen;
  final String descripcion;
  final String precio;

  const Carrusel_admin({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.descripcion,
    required this.precio,
  });
 /* factory Carrusel.fromJson(Map<String, dynamic> json)=> Carrusel(
    id: json["id"], 
    name: json["name"], 
    image: json["image"], 
    description: json["description"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
  };*/
  Carrusel_admin copy() => Carrusel_admin(
    id: id, 
    nombre: nombre, 
    imagen: imagen, 
    descripcion: descripcion,
    precio: precio
  );
}