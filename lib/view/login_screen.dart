import 'package:flutter/material.dart';
import 'package:flutter_rest/auth/auth.dart';
import 'package:flutter_rest/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final Auth auth;

  const LoginScreen({Key key, this.auth}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _clave;
  bool _logueado = false;

  @override
  void initState() {
    super.initState();
    widget.auth.usuarioActual().then((data) {
      setState(() {
        if (data != null)
          this._logueado = true;
        else
          this._logueado = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_logueado)
      return HomeScreen(
        title: 'Cliente REST',
        auth: widget.auth,
      );
    return _login();
  }

  Widget _login() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(21),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value.isEmpty
                    ? 'No puede dejar en blanco este campo'
                    : null,
                onSaved: (value) => this._email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value.isEmpty
                    ? 'No puede dejar en blanco este campo'
                    : null,
                onSaved: (value) => this._clave = value,
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    widget.auth.loginConEmailYClave(_email, _clave);
                    setState(() {
                      this._logueado = true;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
