import 'package:flutter/material.dart';
import 'package:flutter_rest/dao/persona_dao.dart';
import 'package:flutter_rest/model/persona.dart';

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
          child: FutureBuilder<Persona>(
        future: PersonaDAO.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.nombre);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}