class Persona {
  int _id;
  String _nombres;
  String _apellidos;

  Persona({int id, String nombres, String apellidos}) {
    this._id = id;
    this._nombres = nombres;
    this._apellidos = apellidos;
  }

  set setID(int id) => this._id = id;
  int get getID => this._id;

  set setNombres(String nombres) => this._nombres = nombres;
  String get getNombres => this._nombres;

  set setApellidos(String apellidos) => this._apellidos = apellidos;
  String get getApellidos => this._apellidos;

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
        id: json['id'], nombres: json['nombres'], apellidos: json['apellidos']);
  }
  Map<String, dynamic> toJson() =>
      {"id": getID, "nombres": getNombres, "apellidos": getApellidos};
}
