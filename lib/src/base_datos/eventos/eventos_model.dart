class Evento {
  Evento({

    required this.id,
    required this.nombre_cliente,
    required this.titulo,
    required this.fechaInicio,

  });

  String id;
  String nombre_cliente;
  String titulo;
  String fechaInicio;

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
    id            : json["id"],
    nombre_cliente: json["nombre_cliente"],
    titulo        : json["titulo"],
    fechaInicio   : json["fechaInicio"],
  );

  Map<String, dynamic> toJson() => {
    "id"            : id,
    "nombre_cliente": nombre_cliente,
    "titulo"        : titulo,
    "fechaInicio"   : fechaInicio,
  };
}
