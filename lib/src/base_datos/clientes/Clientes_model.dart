class Persona {
  Persona({
    this.nombre = '',
    this.numCelular = 53000000,
    this.direccion = '',
    this.observaciones = '',
  });

  String nombre;
  int numCelular;
  String direccion;
  String observaciones;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
    nombre        : json["nombre"],
    numCelular    : json["numCelular"],
    direccion     : json["direccion"],
    observaciones : json["observaciones"],
  );

  Map<String, dynamic> toJson() => {
    "nombre"          : nombre,
    "numCelular"      : numCelular,
    "direccion"       : direccion,
    "observaciones"   : observaciones,
  };
}
