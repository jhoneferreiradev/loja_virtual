import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual/domain/user.dart' as MyUser;

import '../screens/helpers/firebase_errors.dart';

class UserService extends ChangeNotifier {
  UserService({this.userConnected}) {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? userConnected;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        userConnected = user;
        print(user.uid);
      }
    });
  }

  Future<void> signIn(
      {required MyUser.User user,
      required Function onFail,
      required Function onSuccess}) async {
    _loading = true;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: user.email, password: user.password);
      userConnected = userCredential.user;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    } on Exception catch (e) {
      print(e);
      onFail('Um erro indefinido ocorreu.');
    } finally {
      _loading = false;
    }
  }
}
