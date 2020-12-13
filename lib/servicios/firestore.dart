import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_park/usuarios/usuarios.dart';

class FirestoreServ {
  Firestore _db = Firestore.instance;

  Future<void> addUser(User users) {
    return _db
        .collection('usuarios')
        .document(users.userId)
        .setData(users.toMap());
  }

  Future<User> usuarioCreado(String userId) {
    return _db
        .collection('usuarios')
        .document(userId)
        .get()
        .then((snapshot) => User.fromFirestore(snapshot.data));
  }
}
