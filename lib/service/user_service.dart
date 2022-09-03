import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../domain/local_user.dart';
import '../screens/helpers/firebase_errors.dart';

class UserService extends ChangeNotifier {
  UserService({this.firebaseUserConnected}) {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? firebaseUserConnected;
  LocalUser? localUser;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => localUser != null;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    DocumentSnapshot docUser;

    if (firebaseUser != null) {
      docUser = await firestore.collection('users').doc(firebaseUser.uid).get();
      localUser = LocalUser.fromJson(
          docUser.data() as Map<String, dynamic>, docUser.id);
    } else {
      auth.authStateChanges().listen((User? currentFirebaseUser) async {
        if (currentFirebaseUser != null) {
          final DocumentSnapshot docUser = await firestore
              .collection('users')
              .doc(currentFirebaseUser.uid)
              .get();
          localUser = LocalUser.fromJson(
              docUser.data() as Map<String, dynamic>, docUser.id);
        }
      });
    }

    notifyListeners();
  }

  Future<void> signIn(
      {required LocalUser localUser,
      required Function onFail,
      required Function onSuccess}) async {
    _loading = true;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: localUser.email!, password: localUser.password!);

      await _loadCurrentUser(firebaseUser: userCredential.user);
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

  Future<void> signUp(
      {required LocalUser localUser,
      required Function onFail,
      required Function onSuccess}) async {
    _loading = true;

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: localUser.email!, password: localUser.password!);

      atualizarUserFirebaseConnected(userCredential.user!);
      localUser.id = firebaseUserConnected!.uid;
      saveLocalUser(localUser);
      this.localUser = localUser;
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

  signOut({Function? onSuccess}) {

    auth.signOut();
    localUser = null;
    firebaseUserConnected = null;
    notifyListeners();
    if (onSuccess != null) onSuccess();
  }

  atualizarUserFirebaseConnected(User newFirebaseUserConnected) {
    this.firebaseUserConnected = newFirebaseUserConnected;
  }

  Future<void> saveLocalUser(LocalUser user) async {
    await getDocumentReferenceFor(user).set(user.toJson());
  }

  DocumentReference getDocumentReferenceFor(LocalUser user) {
    return firestore.doc('users/' + user.id!);
  }
}
