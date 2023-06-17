class Carrusel {
  final int id;
  final String nombre;
  final String imagen;
  final String descripcion;
  final String precio;
  final String tipo;

  const Carrusel({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.descripcion,
    required this.precio,
    required this.tipo,
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
  Carrusel copy() => Carrusel(
    id: id, 
    nombre: nombre, 
    imagen: imagen, 
    descripcion: descripcion,
    precio: precio,
    tipo: tipo,
  );
}