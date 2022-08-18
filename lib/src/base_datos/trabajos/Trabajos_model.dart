class Trabajo {
  
  String id;
  String estado_actual;
  String tipo_trabajo;
  String nombre_cliente;
  String direccion;
  String observaciones;
  String fecha;
  
  Trabajo({

    required this.id,
    required this.estado_actual,
    required this.tipo_trabajo,
    required this.nombre_cliente,
    required this.direccion,
    required this.observaciones,
    required this.fecha,

  });

  factory Trabajo.fromJson(Map<String, dynamic> json) => Trabajo(
    id             : json["id"],
    estado_actual  : json["estado_actual"],
    tipo_trabajo   : json["tipo_trabajo"],
    nombre_cliente : json["nombre_cliente"],
    direccion      : json["direccion"],
    observaciones  : json["observaciones"],
    fecha          : json["fecha"],
  );

  Map<String, dynamic> toJson() => {
    "id"            : id,
    "estado_actual" : estado_actual,
    "tipo_trabajo"  : tipo_trabajo,
    "nombre_cliente": nombre_cliente,
    "direccion"     : direccion,
    "observaciones" : observaciones,
    "fecha"         : fecha,
  };
}
