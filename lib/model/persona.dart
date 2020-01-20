class Persona {
  int codigo;
  String nombre;

  Persona({int codigo, String nombre}) {
    this.codigo = codigo;
    this.nombre = nombre;
  }

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(codigo: json['codigo'], nombre: json['nombre']);
  }
}
