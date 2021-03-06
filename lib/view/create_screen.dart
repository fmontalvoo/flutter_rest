import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest/dao/persona_dao.dart';
import 'package:flutter_rest/model/persona.dart';

class CreateScreen extends StatefulWidget {
  final Persona persona;

  const CreateScreen({Key key, this.persona}) : super(key: key);
  @override
  _CreateScreen createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombres;
  String apellidos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear/Modificar'),),
      body: _form(
          persona: widget.persona != null
              ? widget.persona
              : Persona(id: -1, nombres: "", apellidos: "")),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Eliminar'),
        icon: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () {
          PersonaDAO.eliminarPersona(widget.persona.getID);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _form({Persona persona}) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Ingresa tu nombres',
                ),
                controller:
                    TextEditingController(text: '${persona.getNombres}'),
                validator: (value) =>
                    value.isEmpty ? 'Porfavor ingresa tus nombres' : null,
                onSaved: (value) => this.nombres = value,
              ),
              TextFormField(
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Ingresa tus apellidos',
                ),
                controller:
                    TextEditingController(text: '${persona.getApellidos}'),
                validator: (value) =>
                    value.isEmpty ? 'Porfavor ingresa tus apellidos' : null,
                onSaved: (value) => this.apellidos = value,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: RaisedButton(
                  onPressed: () {
                    Persona p = Persona();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      p.setNombres = this.nombres;
                      p.setApellidos = this.apellidos;
                      if (persona.getID != -1)
                        PersonaDAO.actualizarPersona(
                            jsonEncode(p.toJson()), persona.getID);
                      else
                        PersonaDAO.crearPersona(jsonEncode(p.toJson()));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Guardar'),
                ),
              ),
            ],
          ),
        ));
  }
}
