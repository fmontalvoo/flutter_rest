import 'package:flutter/material.dart';
import 'package:flutter_rest/dao/persona_dao.dart';
import 'package:flutter_rest/model/persona.dart';

import 'create_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<Persona>>(
        future: PersonaDAO.listarPersona(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _list(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Añadir'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
      ),
    );
  }

  Widget _list(List<Persona> personas) {
    return ListView.builder(
        itemCount: personas.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.only(),
                child: ListTile(
                  title: Text(
                      '${personas[index].getNombres} ${personas[index].getApellidos}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateScreen(
                                persona: personas[index],
                              )),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
