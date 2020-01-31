import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthResult> loginConEmailYClave(String email, String clave) async {
    try {
      AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: clave);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> usuarioActual() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user;
    } on NoSuchMethodError catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> cerrarSesion() async {
    await _firebaseAuth.signOut();
  }
}
