import 'package:flutter/material.dart';
import 'package:flutter_rest/auth/auth.dart';
import 'package:flutter_rest/dao/persona_dao.dart';
import 'package:flutter_rest/model/persona.dart';

import 'create_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Auth auth;
  HomeScreen({Key key, this.title, this.auth}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(Icons.menu),
              itemBuilder: (_) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        child: const Text('Cerrar sesion'), value: ''),
                  ],
              onSelected: (_) {
                widget.auth.cerrarSesion();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                            auth: widget.auth,
                          )),
                );
              })
        ],
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
